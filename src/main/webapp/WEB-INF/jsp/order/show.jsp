<%@ taglib
	prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
	prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../featureNavigation.jsp"%>
<%@ taglib
		prefix="fmt"
		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib
	prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<c:set var="imagesPath" value="http://konfigurator.viberti.pl/imagesLd/" />
<c:set var="default" value="default.png" />
<sec:authentication var="user" property="principal" />
<script>
	function hideChassis() {
		var x = document.getElementsByClassName("chassis");
		for (var i = 0; i < x.length; i++) {
			if (x[i].style.display === "none") {
				x[i].style.display = "block";
			} else {
				x[i].style.display = "none";
			}
		}
	}
</script>
<div style="min-width: 1000px;">
	<c:if test="${errorMessage!=null && errorMessage!='null'}">

		<p style="background-color: #B24C4C; position:fixed;z-index:9000; margin-left:40%" class="p-5">${errorMessage}
		</p>

	</c:if>
	<div class="card text-dark m-1">


		<div class="card-header bg-info text-left text-light">
			<div>LP. ${order.id}, Order name: ${order.orderName}, Client: ${order.client}, Units:
				${order.unitsToProduce} Created: ${order.createdDate}, Modified:
				${order.lastModifiedDate}, Revision: ${order.revision}
				<div>Price : ${order.price}</div>				
				<div>Pl order number: ${order.plOrder}</div>
			</div>
			<c:if test="${user.authorities=='[ADMIN]'}">
			<a class="btn btn-outline-secondary text-dark" href="/order/edit?orderId=${order.id}">
				<span class="glyphicon glyphicon-edit text-warning"></span>
			</a>
			<a class="btn btn-outline-secondary text-light" href="/matrix?orderId=${order.id}">
				<i class="glyphicon glyphicon-magnet text-warning"></i>
			</a>
			</c:if>
			<a class="btn btn-outline-secondary text-dark" href="/order/show?orderId=${order.id}&edit=true">
				<span class="glyphicon glyphicon-gift text-light"></span>
			</a>
			<a class="btn btn-outline-secondary text-light" href="/order/color/edit?orderId=${order.id}">
				<i class="fa fa-paint-brush text-light"></i>
			</a>
			
			<c:if test="${order.link!=null}">
				<a class="btn btn-outline-secondary text-light" href="${order.link}" target="_blank">Sherpoint</a>
			</c:if>
			<a class="btn btn-outline-secondary text-light" href="/order/ifNewProductFeatures?orderId=${order.id}">Update</a>
			<a class="btn btn-outline-secondary text-light" href="/order/print?orderId=${order.id}">
				<span class="glyphicon glyphicon-print text-light"></span>
			</a>
			<c:if test="${order.noStandard=='TRUE'}">
				<span class="text-warning text-center align-middle" style="font-size:30px;">No standard order</span>
				<span class="float-right">
					<a class="btn btn-outline-info text-dark btn-lg"
						href="/save/product/noStandard?orderId=${order.id}"><span
							class="glyphicon glyphicon-floppy-disk text-warning"></span></a>
				</span>
			</c:if>
		</div>
		<div class="card-body">
			<c:forEach var="feature" items="${order.orderFeatures}">
				<c:choose>
					<c:when test="${feature.productFeature.parent=='Chassis'}">
						<div class="chassis border-left  border-bottom  ml-5">
							<div class="row p-1">
								<div class="col-2">
									<div class="ml-5 p-2 bg-info text-light">${feature.productFeature.name}:</div>
								</div>
								<div class="col-3">
									<div class="ml-5">${feature.feature.name}
										<c:if test="${feature.feature.noStandard=='TRUE'}">
											<a class="btn btn-outline-info text-dark"
												href="/feature/editFeatureNoStandard?featureId=${feature.feature.id}&orderId=${order.id}"><span
													class="glyphicon glyphicon-exclamation-sign text-danger"></span></a>
										</c:if>
										<c:if test="${edit=='TRUE'}">
											<a class="btn btn-outline-info text-dark"
												href="/feature/editFeatureNoStandard?featureId=${feature.feature.id}&orderId=${order.id}&edit=${edit}"><span
													class="glyphicon glyphicon-gift text-warning"></span></a>
										</c:if>
									</div>
								</div>
								<div class="col-1">${feature.feature.index}</div>
								<div class="col-1">${feature.feature.mIndex}</div>
								<c:choose>
									<c:when test="${feature.productFeature.color==true}">
										<div class="col-1 m-1">${feature.color.type}<span
												class="glyphicon glyphicon-tint"
												style="color:${feature.color.hex};"></span></div>
									</c:when>
									<c:otherwise>
										<div class="col-1 m-1"></div>
									</c:otherwise>
								</c:choose>

								<div class="col-1">
									<c:if test="${feature.feature.imagePath!=''}">
										<a href="/im/${feature.feature.imagePath}" target="_blank" class="rys">
											<img src="/im/${feature.feature.imagePath}" alt="Flowers in Chania"
												width="100" onerror="imgError(this)">
										</a>
									</c:if>
								</div>

								<c:if test="${feature.feature.price!='0.0'}">
									<div class="col-1">${feature.feature.price}</div>
								</c:if>
							</div>
						</div>
					</c:when>
					<c:when test="${feature.productFeature.name=='Chassis'}">
						<div class="row border p-1">
							<div class="col-2 bg-info text-light "><button
									class="btn btn-outline-secondry bg-light text-light p-1 m-1"
									onclick="hideChassis()"><span
										class="glyphicon glyphicon-menu-up text-dark"></span></button>
								${feature.productFeature.name}:</div>
							<div class="col-3 m-1">${feature.feature.name}
								<c:if test="${feature.feature.noStandard=='TRUE'}">
									<a class="btn btn-outline-info text-dark"
										href="/feature/editFeatureNoStandard?featureId=${feature.feature.id}&orderId=${order.id}"><span
											class="glyphicon glyphicon-exclamation-sign text-danger"></span></a>
								</c:if>
								<c:if test="${edit=='TRUE'}">
									<a class="btn btn-outline-info text-dark"
										href="/feature/editFeatureNoStandard?featureId=${feature.feature.id}&orderId=${order.id}&edit=${edit}"><span
											class="glyphicon glyphicon-gift text-warning"></span></a>
								</c:if>
							</div>
							<div class="col-1 m-1">${feature.feature.index}</div>
							<div class="col-1 m-1">${feature.feature.mIndex}</div>
							<div class="col-1 m-1">${feature.color.type}<span class="glyphicon glyphicon-tint"
									style="color:${feature.color.hex};"></span></div>
							<div class="col-1 m-1">
								<c:if test="${feature.feature.imagePath!=''}">
									<a href="/im/${feature.feature.imagePath}" target="_blank" class="rys">
										<img src="/im/${feature.feature.imagePath}" alt="Flowers in Chania"
											width="100" onerror="imgError(this)">
									</a>
								</c:if>
							</div>

							<c:if test="${feature.feature.price!='0.0'}">
								<div class="col-1 m-1">${feature.feature.price}</div>
							</c:if>
						</div>
		</div>
		</c:when>

		<c:otherwise>
			<div class="row border-bottom m-1  p-0">
				<div class="col-2 bg-info text-light p-1">${feature.productFeature.name}:</div>
				<div class="col-3 m-1">${feature.feature.name}
					<c:if test="${feature.feature.noStandard=='TRUE'}">
						<a class="btn btn-outline-info text-dark"
							href="/feature/editFeatureNoStandard?featureId=${feature.feature.id}&orderId=${order.id}"><span
								class="glyphicon glyphicon-exclamation-sign text-danger"></span></a>
					</c:if>
					<c:if test="${edit=='TRUE'}">
						<a class="btn btn-outline-info text-dark"
							href="/feature/editFeatureNoStandard?featureId=${feature.feature.id}&orderId=${order.id}&edit=${edit}"><span
								class="glyphicon glyphicon-gift text-warning"></span></a>
					</c:if>
				</div>
				<div class="col-1 m-1">${feature.feature.index}</div>
				<div class="col-1 m-1">${feature.feature.mIndex}</div>
				<c:choose>
					<c:when test="${feature.productFeature.color==true}">
						<div class="col-1 m-1">${feature.color.type}<span class="glyphicon glyphicon-tint"
								style="color:${feature.color.hex};"></span></div>
					</c:when>
					<c:otherwise>
						<div class="col-1 m-1"></div>
					</c:otherwise>
				</c:choose>
				<div class="col-1 m-1">
					<c:if test="${feature.feature.imagePath!=''}">
						<a href="/im/${feature.feature.imagePath}" target="_blank" class="rys">
							<img src="/im/${feature.feature.imagePath}" alt="Flowers in Chania" width="100"
								onerror="imgError(this)">
						</a>
					</c:if>
				</div>

				<c:if test="${feature.feature.price!='0.0'}">
					<div class="col-1 m-1">${feature.feature.price}</div>
				</c:if>
			</div>
		</c:otherwise>
		</c:choose>
		</c:forEach>

	</div>
	<div class="card-footer bg-info text-right text-light">
		<div>Modified by: ${order.lastModifiedBy}</div>

	</div>
</div>



</div>



<div class="container p-5">
	<c:forEach var="ordAud" items="${aud}">
		<div class="row border bg-secondary text-light">
			<div class="col ">Order name: ${ordAud.order.orderName},
				Price: ${ordAud.order.price}, Client: ${ordAud.order.client}, Units:
				${ordAud.order.unitsToProduce}
				, Modified by: ${ordAud.order.lastModifiedBy}
				, revision: ${ordAud.order.revision}
				, date: ${ordAud.date}
				<c:if test="${ordAud.order.noStandard=='true'}">
				<span class="text-warning">, NOT STANDARD</span>
				</c:if>
				</div>
		</div>
		<c:forEach var="listRow" items="${ordAud.featureAuds}">
			<div class="row">
				<div class="col">${listRow.pfName}</div>
				<div class="col">${listRow.oldFeature}</div>
				<div class="col">${listRow.newFeature}</div>
			</div>
		</c:forEach>


		<%-- <div class="col-2">
				<fmt:formatDate
					type="date"
					value="${order[1].revisionDate}"
					pattern="yyyy-MM-dd, HH:mm" />
			</div>

			<div class="col-2">${order[1].username}</div>
		</div>
		<div>LP. ${order[0].id}, Order name: ${order[0].orderName},
			Price: ${order[0].price}, Client Address: ${order[0].client}, Units:
			${order[0].unitsToProduce}</div> --%>
	</c:forEach>

</div>