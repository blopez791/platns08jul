public with sharing class FrequencyService {
   static Map<String, Integer> daysByFrequency = new Map<String, Integer>();

   static {
      daysByFrequency.put('daily',1);
      daysByFrequency.put('Twice per week',3);
      daysByFrequency.put('weekly',7);
      daysByFrequency.put('Every other week',15);
      daysByFrequency.put('Monthly',30);
      daysByFrequency.put('Every three months',90);
      daysByFrequency.put('Not needed',999);
   }

   static Set<Integer> summerMonths = new Set<Integer>{5,6,7,8,9};

   public static Integer getWateringDays(Species__c specie, DateService dateServiceInstance){
      System.debug('Specie: '+specie);
      //Integer month = System.today().month();
      
      //Mock for testing
      Integer month = dateServiceInstance.getCurrentMonth();
      
      if(summerMonths.contains(month)) {
         System.debug('Frecuencia summer: '+specie.Summer_Watering_Frequency__c);
         System.debug('Frecuencia mapa summer: '+daysByFrequency.get(specie.Summer_Watering_Frequency__c));
         return daysByFrequency.get(specie.Summer_Watering_Frequency__c);
      }
      else {
         System.debug('Frecuencia winter: '+specie.Winter_Watering_Frequency__c);
         System.debug('Frecuencia mapa winter: '+daysByFrequency.get(specie.Winter_Watering_Frequency__c));
         return daysByFrequency.get(specie.Winter_Watering_Frequency__c);
      }
   }

   public static Integer getFertilizationgDays(Species__c specie){
      return 20;
   }
}