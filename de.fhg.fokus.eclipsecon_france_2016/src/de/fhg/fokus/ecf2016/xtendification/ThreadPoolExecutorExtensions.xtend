package de.fhg.fokus.ecf2016.xtendification

import java.util.concurrent.ThreadPoolExecutor
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.concurrent.TimeUnit
import java.util.concurrent.BlockingQueue
import java.util.concurrent.ThreadFactory
import java.util.concurrent.RejectedExecutionHandler
import java.util.concurrent.ThreadPoolExecutor.AbortPolicy
import java.util.concurrent.Executors
import java.util.concurrent.ForkJoinPool
import java.util.concurrent.SynchronousQueue
import java.util.concurrent.LinkedBlockingDeque

class ThreadPoolExecutorExtensions {

	def static void main(String[] args) {
		callConstructor()
		
		callBuilder()
	}
	
	/**
	 * Direct call of ThreadPoolExecutor constructor
	 */
	def static callConstructor() {
		val queue = new LinkedBlockingDeque
		val corePoolSize = 1
		val maximumPoolSize = 5
		val keepAliveTime = 200
		val keepAliveTimeUnit = TimeUnit.MILLISECONDS
		val pool = new ThreadPoolExecutor(corePoolSize, maximumPoolSize, keepAliveTime, keepAliveTimeUnit, queue)
	}
	
	/**
	 * Builder style instantiation of ThreadPoolExecutor
	 */
	def static callBuilder() {
		val pool = ThreadPoolExecutor.create [
			corePoolSize = 1
			maximumPoolSize = 5
			keepAliveTime = 200
			keepAliveTimeUnit = TimeUnit.MILLISECONDS
			workQueue = new LinkedBlockingDeque
		]
	}

	/**
	 * Extension method called on ThreadPoolExecutor class object
	 */
	static def ThreadPoolExecutor create(Class<ThreadPoolExecutor> clazz, (ThreadPoolExecutorBuilder)=>void config) {
		val builder = new ThreadPoolExecutorBuilder
		config.apply(builder)
		builder.build
	}

	@Accessors public static class ThreadPoolExecutorBuilder {

		private static val defaultStrategy = new AbortPolicy()

		private int corePoolSize = 0
		private int maximumPoolSize = Integer.MAX_VALUE
		private long keepAliveTime = 60L
		private TimeUnit keepAliveTimeUnit = TimeUnit.SECONDS
		private BlockingQueue<Runnable> workQueue = null
		private ThreadFactory threadFactory = null
		private RejectedExecutionHandler handler = defaultStrategy

		def build() {
			new ForkJoinPool
			val threadFactory = this.threadFactory ?: Executors.defaultThreadFactory()
			val workQueue = this.workQueue ?: new SynchronousQueue<Runnable>()
			new ThreadPoolExecutor(corePoolSize, maximumPoolSize, keepAliveTime, keepAliveTimeUnit, workQueue, threadFactory,
				handler)
		}
	}

}
