import { LightningElement,wire } from 'lwc';
import getFilteredSpecies from '@salesforce/apex/SpeciesService.getFilteredSpecies';

export default class SpeciesList extends LightningElement {
   //PROPERTIES, GETTERS & SETTERS
   searchText="";
   
   //LIFECYCLE HOOKS

   //WIRE
   @wire(getFilteredSpecies,{searchText: '$searchText'}) //para operaciones de lectura
   species;
   //species.data
   //species.error

   //METHODS
   handlerInputChange(event){
      const searchTextAux = event.target.value;
      console.log('Busqueda: '+searchTextAux);
      console.log('Busqueda lng: '+searchTextAux.length);

      if(searchTextAux.length >= 3 || searchTextAux.length===0) {
         console.log('enter here');
         this.searchText = searchTextAux;
      }
   }
}