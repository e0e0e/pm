<%@ taglib
	prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
	prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<div id="cloud" style="display:none;"></div>
<div class="container">
	<%@include file="../featureNavigation.jsp"%>
	<c:if test="${errorMessage!=null}">

		<p style="background-color: red;">${errorMessage}</p>

	</c:if>

	<sec:authentication var="loggedUser" property="principal" />
	<div class="row">
		<div class="col-6 bg-info">
			<c:choose>
				<c:when test="${param.edit=='true'}">
					<h1>Make new no sandard Feature</h1>
				</c:when>
				<c:otherwise>
					<h1>Edit no sandard Feature</h1>
				</c:otherwise>
			</c:choose>

			<form method="post"
				action="/featureChange?userId=${loggedUser.id}&featureId=${param.featureId}&orderId=${orderId}&edit=${param.edit}">

				<label>Feature Name:</label><br />
				<textarea rows="2" class="text-dark w-100 form-control" name="name">${feature.name}</textarea>
				<br /> <label>Feature Description:</label><br />
				<textarea rows="4" class="text-dark" name="description">${feature.description}</textarea>
				<br>
				<input type="checkbox" name="noStandard" value="true" <c:if test="${feature.noStandard=='true'}">
				checked
				</c:if>
				>No standard
				<br />
				<br /> <label>Feature Image:</label>
				<br />
				<input type="text" class="text-dark" name="imagePath" value="${feature.imagePath}"><br />
				<label>Price:</label><br />
				<input type="text" class="text-dark" name="price" value="${feature.price}"><br />
				<label>Index:</label><br />
				<input type="text" class="text-dark" name="index" value="${feature.index}"><br />
				<label>Index M:</label><br />
				<input type="text" class="text-dark" name="mIndex" value="${feature.mIndex}"><br /> <br>
				<input type="submit" class="text-light btn btn-outline-secondary" value="Save">


			</form>
		</div>
		<div class="col-6 bg-secondary">
			<h1>Select existing Feature</h1>
			<form method="post" action="/feature/existingFeatureChange?featureId=${param.featureId}&orderId=${orderId}">
				<label>Features:</label><br />
				<select name="existingFeatureId" id="existingFeatureId" calss="form-control w-100" class="custom-select"
					style="font-size: 14px;" size="10">
					<c:forEach var="exFeature" items="${existingFeatures}">
						<option value="${exFeature.id}">${exFeature.name}_${exFeature.index}</option>

					</c:forEach>
					<select>
						<br>
						<input type="submit" class="text-dark btn btn-outline-info m-5" value="Save Existing">
			</form>
		</div>
	</div>
</div>

<script>

var spacesToAdd = 5;
var biggestLength = 0;

$("#existingFeatureId option").each(function(){
var len = $(this).text().length;
    if(len > biggestLength){
        biggestLength = len;
    }
});
var padLength = biggestLength + spacesToAdd;
$("#existingFeatureId option").each(function(){
    var parts = $(this).text().split('_');
    var strLength = parts[0].length;
    for(var x=0; x<(padLength-strLength); x++){
        parts[0] = parts[0]+' '; 
    }
    $(this).text(parts[0].replace(/ /g, '\u00a0')+parts[1]).text;
});

$('option').hover(function(){
    
	document.getElementById("cloud").innerHTML=$(this).text();
	document.getElementById("cloud").style.display="block";


});
</script>