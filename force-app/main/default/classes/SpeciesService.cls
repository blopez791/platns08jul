public with sharing class SpeciesService {
   @AuraEnabled(cacheable = true) //decorador para exponer metodos tanto en AURA como en LWC
   public static List<Species__c> getFilteredSpecies(String searchText) {
      String likeValue = '%'+searchText+'%';
      return [
         SELECT Id, Name, Description__c, Image_URL__c, Location__c 
         FROM Species__c
         WHERE Name LIKE:likeValue
      ];
   }
}