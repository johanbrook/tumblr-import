# Tumblr backup in CoffeeScript

Simple script I'm using to fetch my Tumblr *text posts* and save to file.

Markdown formatted posts will be saved with an `.md` extension, otherwise `.txt`.

## Usage

### From the command line:

	coffee tumblr.coffee <Tumblr URL> [path]

where <Tumblr URL> is mandatory and can be `something.tumblr.com` or a custom domain name, such as `log.johanbrook.com`. `path` is where all posts will be saved, and is optional, and defaults to the current directory. If specified, it can be relative or absolute.

### In code

	client = new Tumblr(blog_url, api_key)
	# path defaults to current directory
	# limit defaults to 20
	client.fetch_posts(path: <directory>, limit: <limit>)

## Left to do

- Create a workaround for Tumblr's limit on twenty posts for every fetch.

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
