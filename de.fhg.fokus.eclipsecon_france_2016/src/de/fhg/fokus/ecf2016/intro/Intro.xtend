package de.fhg.fokus.ecf2016.intro

import java.util.concurrent.ForkJoinPool
import org.eclipse.swt.SWT
import org.eclipse.swt.layout.FillLayout
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.widgets.Display
import org.eclipse.swt.widgets.Shell
import static org.eclipse.xtext.xbase.lib.BigDecimalExtensions.*

class Intro {
	def static void main(String[] args) {
		
		// if lambda last parameter, write after braces
		// if method call with empty braces (), they can be omitted
		val pool = ForkJoinPool.commonPool;
		pool.execute([ println("foo") ])
		pool.execute [ 
			println("foo")
		]

		val Display display = new Display();
		val Shell shell = new Shell(display);
		shell.layout = new FillLayout
		val button = new Button(shell, SWT.PUSH)
		button.setText("Press Me")
		// setter can be replaced with assignment
		button.text = "Press Me"
		shell.visible = true
		while (!shell.disposed) {
			if(!display.readAndDispatch) 
				display.sleep()
		}
		display.dispose
		
		emphasize("boo")
		"boo".emphasize
		
		println( operator_plus(1e15bd, 1e-4bd) )
		println( 1e15bd + 1e-4bd )
		
		println(1e15d + 1e-41d)
	}
	
	def static String emphasize(String input) {
		input + "!"
	}

}
