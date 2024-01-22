trigger PlantTrigger on Plant__c (before insert, before update) {
   //Cuando se crea o actualiza una planta (cambiando su fecha de riego) --> calcular la sig fecha riego


   if(Trigger.isInsert || Trigger.isUpdate){
      //Precarga de objetos relacionados
      Set<Id> specieIds = new Set<Id>();
      for(Plant__c newPlant:Trigger.new){
         Plant__c oldPlant = (Trigger.isUpdate) ? Trigger.oldMap.get(newPlant.Id) : null;

         if(oldPlant==null || (oldPlant.Last_Watered__c != newPlant.Last_Watered__c)){
            specieIds.add(newPlant.Species__c);
         }
      }

      List<Species__c> species = [SELECT  Summer_Watering_Frequency__c,Winter_Watering_Frequency__c FROM Species__c WHERE Id IN:specieIds];

      Map<Id,Species__c> speciesById = new Map<Id,Species__c>(species);

      //Si esta cambiando la fecha de riego
      //Trigger.old (Trigger.oldMap) / Trigger.new (Trigger.newMap)

      for(Plant__c newPlant:Trigger.new){
         Plant__c oldPlant = (Trigger.isUpdate) ? Trigger.oldMap.get(newPlant.Id) : null;

         if(oldPlant==null || (oldPlant.Last_Watered__c != newPlant.Last_Watered__c)){
            //Calcular sig fecha riego
            //Ver que especie es mi planta
            Id specieId = newPlant.Species__c;
            Species__c specie = speciesById.get(specieId);

            //Pedir freq de riego para esa especie
            Integer daysToAdd = FrequencyService.getWateringDays(specie, new DateService());

            //sig fecha riego = ultima + dias devueltos
            newPlant.Next_Water__c = newPlant.Last_Watered__c.addDays(daysToAdd);
         }
      }
   }

   //Cuando se crea o actualiza una planta (cambiando su fecha de abono) --> calcular la sig fecha abono
}