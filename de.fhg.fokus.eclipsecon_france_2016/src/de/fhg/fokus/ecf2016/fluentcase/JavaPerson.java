package de.fhg.fokus.ecf2016.fluentcase;

import java.util.Optional;

public class JavaPerson {
	
	public static void main(String[] args) {
		Person dareDevil = Person.orphan("Matt Murdock", "St Agnes Orphanage");
		ParentalStatus parentalStatus = dareDevil.getParentalStatus();
		if(parentalStatus instanceof ParentalStatus.Parents) {
			ParentalStatus.Parents parents = (ParentalStatus.Parents) parentalStatus;
			Optional<Person> momOpt = parents.getMom();
			Optional<Person> dadOpt = parents.getDad();
			momOpt.ifPresent((mom) -> dadOpt.ifPresent((dad) -> {
				System.out.println("Mother: "+mom.getName()+",  Father: "+ dad.getName());
			}));
		} else {
			if(parentalStatus instanceof ParentalStatus.Orphan) {
				String orphanage = ((ParentalStatus.Orphan) parentalStatus).getOrphanage();
				System.out.println("Orphanage: "+orphanage);
			} else {
				System.out.println("Unknown parental status");
			}
		}
	}

	private static abstract class ParentalStatus{
		
		static final class Parents extends ParentalStatus {
			private final Optional<Person> mom;
			private final Optional<Person> dad;
			public Parents(Person mom, Person dad) {
				this.mom = Optional.ofNullable(mom);
				this.dad = Optional.ofNullable(dad);
			}
			public Optional<Person> getMom() {
				return mom;
			}
			public Optional<Person> getDad() {
				return dad;
			}
			
		}
		
		static final class Unknown extends ParentalStatus {
		}
		
		
		static final class Orphan extends ParentalStatus {
			private final String orphanage;

			public Orphan(String orphanage) {
				super();
				this.orphanage = orphanage;
			}
			
			public String getOrphanage() {
				return orphanage;
			}
		}
	}
	
	private static class Person {
		private final String name;
		private final ParentalStatus parentalStatus;

		private Person(String name, ParentalStatus parentalStatus) {
			this.parentalStatus = parentalStatus;
			this.name = name;
		}
		
		public static Person orphan(String name, String orphanage) {
			return new Person(name, new ParentalStatus.Orphan(orphanage));
		}
		
		public static Person withParents(String name, Person mom, Person dad) {
			return new Person(name, new ParentalStatus.Parents(mom, dad));
		}
		
		public static Person withUnknownParents(String name) {
			return new Person(name, new ParentalStatus.Unknown());
		}
		
		public ParentalStatus getParentalStatus() {
			return parentalStatus;
		}
		
		public String getName() {
			return name;
		}
	}

}
