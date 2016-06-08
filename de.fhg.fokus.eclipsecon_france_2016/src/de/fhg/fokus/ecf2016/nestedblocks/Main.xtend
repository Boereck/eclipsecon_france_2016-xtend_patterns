package de.fhg.fokus.ecf2016.nestedblocks

import static de.fhg.fokus.ecf2016.nestedblocks.Server.server
import static extension de.fhg.fokus.ecf2016.nestedblocks.HtmlBuilder.*
import de.fhg.fokus.ecf2016.nestedblocks.Server.ServerConfig
import de.fhg.fokus.ecf2016.nestedblocks.Server.Response

class Main {
	def static void main(String[] args) {

		// with syntactic sugar
		server [
			port = 80
			get("/hello?name=$name") [
				header("content" -> "text/html")
				html [
					h1("Hello " + param('name'))
				]
			]
		]

		// without syntactic sugar
		server([ ServerConfig conf |
			conf.setPort(80)
			conf.get("/hello?name=$name", [ Response response |
				response.header(Pair.of("content", "text/html"))
				return HtmlBuilder.html(response, [ HtmlBuilder builder |
					builder.h1("Hello " + builder.param('name'))
				])
			])
		])

	}
}
