<%@ taglib
	prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<div class="container">
	<%@include file="../featureNavigation.jsp"%>

	<div id="rest"></div>
	<h3>
		Configuration of order
	</h3>


	<div class="card text-dark bg-light m-1">


		<div class="card-header bg-info text-left text-light"></div>


		<div class="card-body ">
			<form
				id="myFilterForm"
				method="post"
				action="/filter/orderCreate">
<div class="row border-bottom">
<div class="col-2 m-1">Product Feature</div>
<div class="col-5 m-1">Select</div>

</div>
				
					<c:forEach
						var="configList"
						items="${configuration.configurationList}">
						<div class="row">
							<div class="col-2 
							<c:if test="${configList.parent!='Chassis'}">
							bg-info text-light
							</c:if>
							">${configList.name}</div>
							<div class="col-5 m-1">
								<select required
									name="${configList.id}"
									id="${configList.name}"
									onchange='changeAction(this,${configList.id})'
									class="w-100">
									<option
										value=""
										selected
										disabled
										hidden>Select</option>
									<c:forEach
										var="feature"
										items="${configList.feature}">
										<option value="${feature.id}">${feature.name}</option>

									</c:forEach>
								</select>
							
							</div>
						</div>
					</c:forEach>
				
				<input
					id="saveButton"
					type="submit"
					value="Save" class="m-4">
			</form>
		</div>
		<div class="card-footer bg-info text-right text-light"></div>
	</div>



</div>
<script>
function changeAction(val,da) {
	
	 var xhttp = new XMLHttpRequest();
	    xhttp.onreadystatechange = function() {
	         if (this.readyState == 4 && this.status == 200) {
	        	 
	        	 products=JSON.parse(this.responseText);
	        	
	        	 
	        	 for (let key in products){
	        		 let select='<option value="" selected disabled hidden>Select</option>';
	        		   if(products.hasOwnProperty(key)){

	        		    if(products[key].length>1){	        		   
	        		     for (let k in products[key]){
	        		    	
	        		    	
	        		    	 if(products[key][k].selected==false){
	        		    	 select=select.concat('<option value="'+products[key][k].id+'">'+products[key][k].name+'</option>');
	        		    	 }else{
	        		    		 select=select.concat('<option value="'+products[key][k].id+'" selected>'+products[key][k].name+'</option>'); 	 
	        		    	 }
	        	
	        		    	 }
	        		     }else{
	        		    	 select=select.concat('<option value="'+products[key][0].id+'" selected>'+products[key][0].name+'</option>');  
	        		     }
	        		     select.concat("</select>");
	        		   }
					   if(key!=null){
console.log(key);
	        		   document.getElementById(key).innerHTML=select;
					   }
	        		}
	        	 
	        	
	      
	         }
	    };
	    
	    document.getElementById("saveButton").style.display = 'block';
	    let arr={};
  	  for (var i = 0; i < document.getElementById("myFilterForm").elements.length; i++) {
  		  let valueFromForm=document.getElementById("myFilterForm").elements[i].value;
  		
  		  if(valueFromForm!="" && valueFromForm!='Save'){
  			  arr[document.getElementById("myFilterForm").elements[i].id]=valueFromForm;
  	
  		  }
  		}

        let fString=JSON.stringify(arr);
    
	    xhttp.open("POST", "/product/matching", true);
	    xhttp.setRequestHeader("Content-type", "application/json");
		xhttp.send(fString);
	
}
</script>