# Tumblr backup in CoffeeScript

Simple script I'm using to fetch my Tumblr *text posts* and save to file.

Markdown formatted posts will be saved with an `.md` extension, otherwise `.txt`.

## Dependencies

Except for [Node.js](http://nodejs.org/) and [CoffeeScript](coffeescript.org), there are no external dependenices.

## Usage

### From the command line

	coffee tumblr.coffee <Tumblr URL> [path]

where <Tumblr URL> is mandatory and can be `something.tumblr.com` or a custom domain name, such as `log.johanbrook.com`. `path` is where all posts will be saved, and is optional, and defaults to the current directory. If specified, it can be relative or absolute.

**Important:** In order run the script, a `config.json` file must exists in the same directory as `tumblr.coffee`, and include the following:

	{
		"api_key": "<api key from tumblr>"
	}

In order to obtain an API key, just register an application here: http://www.tumblr.com/oauth/apps. Don't worry: no weird OAuth stuff has to be done.

### In code

	client = new Tumblr(blog_url, api_key)
	# path defaults to current directory
	# limit defaults to 20
	client.save_posts path: "./posts", limit: 15, (error, blog) ->
		# error can be null or an error thrown
		# On success, blog will be an object with this info: http://www.tumblr.com/docs/en/api/v2#blog-info
		unless error
			console.log "Saved posts from #{blog.title}!"

## Left to do

- Create a workaround for Tumblr's limit on max twenty posts for every fetch.
- Only fetch new posts since last fetch, if possible.
- Add metadata to top of saved file, like YAML Front matter with date, etc.

## License

http://www.wtfpl.net/about

       DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                   Version 2, December 2004 

Copyright (C) 2013 Johan Brook 

Everyone is permitted to copy and distribute verbatim or modified 
copies of this license document, and changing it is allowed as long 
as the name is changed. 

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

 0. You just DO WHAT THE FUCK YOU WANT TO.
