package de.fhg.fokus.ecf2016.fluentcase

import org.eclipse.xtend.lib.annotations.Accessors


class Person {


	def static void main(String[] args) {
		

		val daredevil = Person::orphan("Matt Murdock", "St Agnes Orphanage")
		daredevil.parentalStatus
			.caseParents [ mom, dad |
				println('''Mother: «mom.name»,  Father: «dad.name»''')
			].caseOrphan [ orphanage |
				println("Orphanage: " + orphanage)
			].caseUnknown [
				println("Unknown parental status")
			]

	}

	@Accessors val String name
	val Person mom
	val Person dad
	val String orphanage
	val statusChecker = new ParentalDataCheckerNotFound(this)

	private new(String name, Person mom, Person dad, String orphanage) {
		this.name = name
		this.mom = mom
		this.dad = dad
		this.orphanage = orphanage
	}

	def getMom() {
		mom
	}
	
	def getDad() {
		dad
	}
	
	def getOprphanage() {
		orphanage
	}

	/**
	 * Factory method for a Person that is an orphan
	 */
	public static def Person orphan(String name, String orphanage) {
		new Person(name, null, null, orphanage)
	}
	
	public static def Person withUnknownParentalStatus(String name, String orphanage) {
		new Person(name, null, null, null)
	}

	/**
	 * Factory method for a Person where mom and dad are known.
	 */
	public static def Person parentedPerson(String name, Person mom, Person dad) {
		new Person(name, mom, dad, null)
	}

	public def ParentalStatusChecker parentalStatus() {
		statusChecker
	}

	// this version of case object does not support expression like evaluation,
	// but does not create objects on case matching
	public static interface ParentalStatusChecker {
		def ParentalStatusChecker caseParents((Person, Person)=>void momAndDadConsumer)

		def ParentalStatusChecker caseOrphan((String)=>void orphanageConsumer)

		def ParentalStatusChecker caseUnknown(()=>void unknownConsumer)
	}

	private static val PARENTAL_CHECKER_FOUND = new ParentalStatusChecker() {

		override ParentalStatusChecker caseParents((Person, Person)=>void momAndDad) {}

		override caseOrphan((String)=>void orphanageConsumer) {}

		override caseUnknown(()=>void unknownConsumer) {}

	}

	private static final class ParentalDataCheckerNotFound implements ParentalStatusChecker {

		val Person person

		new(Person person) {
			this.person = person
		}

		private static def <T, V> >>>(T input, (T)=>V func) {
			func.apply(input)
		}

		override caseParents((Person, Person)=>void momAndDad) {
			person >>> [
				if (mom!=null && dad!=null) {
					momAndDad.apply(mom, dad)
					PARENTAL_CHECKER_FOUND
				} else {
					this
				}
			]
		}

		override caseOrphan((String)=>void orphanageConsumer) {
			val orphanage = person.orphanage
			if (orphanage!=null) {
				orphanageConsumer.apply(orphanage)
				PARENTAL_CHECKER_FOUND
			} else {
				this
			}
		}

		override caseUnknown(()=>void unknownConsumer) {
			person >>> [
				if (orphanage == null && mom==null && dad==null) {
					unknownConsumer.apply()
					PARENTAL_CHECKER_FOUND
				} else {
					this
				}
			]
		}

	}
}
