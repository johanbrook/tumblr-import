http = 	require "http"
fs = 	require "fs"
path = 	require "path"


class Tumblr

	constructor: (blog_name, api_key) ->
		@api_url = this._build_url(blog_name, api_key)

	fetch_posts: (options) ->
		settings = 
			limit: options?.limit or 20
			path: options?.path or "./"

		url = @api_url + "&limit=#{settings.limit}"
		this._getJSON url, (status, json) =>
			return unless json

			data = json.response
			console.log "Fetched #{data.total_posts} text posts from '#{data.blog.title}'"

			this._mkpathSync settings.path
			location = this._add_trailing_slash settings.path
			
			console.log "Saving to #{location} ..."
			data.posts.forEach (post) =>
				this._save_post post, location

	_build_url: (blog_name, key) ->
		"http://api.tumblr.com/v2/blog/#{blog_name}/posts/text?api_key=#{key}&filter=raw"

	_add_trailing_slash: (string) ->
		if string[string.length-1] isnt "/" then string+"/" else string

	_mkpathSync: (dirpath) ->
		dir = path.resolve dirpath

		try
			unless fs.statSync(dirpath).isDirectory()
			 	throw new Error dirpath + " exists and is not a directory"
		catch e
			if e.code is 'ENOENT'
				this._mkpathSync(path.dirname(dirpath))
				fs.mkdirSync(dirpath)
			else
				throw e

	_save_post: (post, location) ->
		filename = this._build_filename post
		body = ""
		if post.title
			body += "# #{post.title}\n\n"

		body += post.body
		path = location + filename

		fs.writeFile path, body, (error) ->
			throw error if error

		return true


	_build_filename: (post) ->
		title = post.title or post.date
		ext = if post.format is "markdown" then ".md" else ".txt"
		title + ext


	_getJSON: (url, callback) ->
		output = ""

		request = http.get url, (response) ->
			response.setEncoding "utf8"

			response.on "data", (chunk) ->
				output += chunk

			response.on "end", -> 
				json = JSON.parse(output)
				callback(response.statusCode, json)

		request.on "error", (error) ->
			console.error "Something went wrong fetching from #{url}"
			console.log error.message


blog_name = process.argv[2]

unless blog_name
	console.error "You must provide a Tumblr url to fetch from!"
	console.log "Usage: tumblr <url> [path]"
	process.exit(1)

fs.exists "config.json", (exists) ->
	if exists
		contents = fs.readFileSync "config.json", "utf-8"
		config = JSON.parse contents
		dir = process.argv[3]

		if config.api_key
			run_import config.api_key, dir
		else
			console.error "Couldn't find a Tumblr API key in your config.json file"
			console.log "Put {'api_key': '<KEY>'} in a config.json file"
			process.exit(1)

	else 
		console.error "You must provide a config.json!"
		process.exit(1)

run_import = (api_key, directory) ->
	console.log "Starting import to #{directory} ..."
	client = new Tumblr(blog_name, api_key)
	client.fetch_posts path: directory
