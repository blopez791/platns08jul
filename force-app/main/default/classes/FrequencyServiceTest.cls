@isTest
private with sharing class FrequencyServiceTest {
   @isTest
   static void getWateringDays_wateringFreqDailyWinter_oneDay(){

      DateServiceMock mock = new DateServiceMock();
      mock.monthToReturn = 1;

      DateService mockDateService = (DateService) Test.createStub(DateService.class, mock);

      //GIVEN - escenario
      Species__c specie = new Species__c();
      specie.Winter_Watering_Frequency__c = 'daily';
      specie.Summer_Watering_Frequency__c = 'weekly';
      
      //WHEN - llamada el metodo
      Integer days = FrequencyService.getWateringDays(specie,mockDateService);

      //THEN - resultados
      Integer expectedDays = 1;
      System.assertEquals(expectedDays,days,'Expected 1 day returned');
   }

   @isTest
   static void getWateringDays_wateringFreqDailySummer_oneDay(){

      DateServiceMock mock = new DateServiceMock();
      mock.monthToReturn = 8;

      DateService mockDateService = (DateService) Test.createStub(DateService.class, mock);

      //GIVEN - escenario
      Species__c specie = new Species__c();
      specie.Winter_Watering_Frequency__c = 'weekly';
      specie.Summer_Watering_Frequency__c = 'daily';
      
      //WHEN - llamada el metodo
      Integer days = FrequencyService.getWateringDays(specie,mockDateService);

      //THEN - resultados
      Integer expectedDays = 1;
      System.assertEquals(expectedDays,days,'Expected 1 day returned');
   }

   @isTest
   static void getWateringDays_wateringFreqTwicePerWeekWinter_threeDays(){

      DateServiceMock mock = new DateServiceMock();
      mock.monthToReturn = 1;

      DateService mockDateService = (DateService) Test.createStub(DateService.class, mock);

      //GIVEN - escenario
      Species__c specie = new Species__c();
      specie.Winter_Watering_Frequency__c = 'Twice per week';
      specie.Summer_Watering_Frequency__c = 'daily';
      
      //WHEN - llamada el metodo
      Integer days = FrequencyService.getWateringDays(specie,mockDateService);

      //THEN - resultados
      Integer expectedDays = 3;
      System.assertEquals(expectedDays,days,'Expected 3 day returned');
   }


   public class DateServiceMock implements System.StubProvider {
      
      public Integer monthToReturn;

      public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, 
         Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, 
         List<Object> listOfArgs) {
         
         // The following debug statements show an example of logging 
         // the invocation of a mocked method.
         
         // You can use the method name and return type to determine which method was called.
         System.debug('Name of stubbed method: ' + stubbedMethodName);
         System.debug('Return type of stubbed method: ' + returnType.getName());
         
         // You can also use the parameter names and types to determine which method 
         // was called.
         for (integer i =0; i < listOfParamNames.size(); i++) {
               System.debug('parameter name: ' + listOfParamNames.get(i));
               System.debug('  parameter type: ' + listOfParamTypes.get(i).getName());
         }
         
         // This shows the actual parameter values passed into the stubbed method at runtime.
         System.debug('number of parameters passed into the mocked call: ' + 
               listOfArgs.size());
         System.debug('parameter(s) sent into the mocked call: ' + listOfArgs);


         //Emular el comportamiento deseado
         return monthToReturn;

      }
   }
}