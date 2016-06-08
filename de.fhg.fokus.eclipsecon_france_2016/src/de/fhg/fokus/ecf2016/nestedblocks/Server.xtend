package de.fhg.fokus.ecf2016.nestedblocks
import de.fhg.fokus.ecf2016.nestedblocks.Server.Response
import org.eclipse.xtend.lib.annotations.Delegate
import java.util.concurrent.CompletableFuture

class Server {
	
	static def server((ServerConfig)=>void block) {
		// TODO implement
	}
	
	static class ServerConfig {
		def void setPort(int portNr) {
		// TODO implement
		}
		
		def void get(String urlPattern, (Response)=>CompletableFuture<String> block) {
		// TODO implement
		}
	}
	
	static interface Response {
		def String param(String name)
		def void header(Pair<String,String>... headerEntry)
	}
	
}

class HtmlBuilder implements Response {
	
	@Delegate
	private val Response response
	
	new(Response response) {
		this.response = response
	}
	
	static def CompletableFuture<String> html(Response response, (HtmlBuilder)=>void block) {
		// TODO implement
	}
	
	def void h1(String content){
		// TODO implement
	}
}