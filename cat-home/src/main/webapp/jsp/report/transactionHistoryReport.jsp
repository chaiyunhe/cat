<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<jsp:useBean id="ctx"	type="com.dianping.cat.report.page.transaction.Context"	scope="request" />
<jsp:useBean id="payload"	type="com.dianping.cat.report.page.transaction.Payload"	scope="request" />
<jsp:useBean id="model"	type="com.dianping.cat.report.page.transaction.Model" scope="request" />

<a:historyReport title="History Report">
	<jsp:attribute name="subtitle">From ${w:format(payload.historyStartDate,'yyyy-MM-dd HH:mm:ss')} to ${w:format(payload.historyEndDate,'yyyy-MM-dd HH:mm:ss')}</jsp:attribute>
	<jsp:body>
	<res:useCss value='${res.css.local.jqueryUI_css}' target="head-css" />
	<res:useCss value='${res.css.local.calendar_css}' target="head-css" />
	<res:useJs value="${res.js.local.jqueryMin_js}" target="head-js" />
	<res:useJs value="${res.js.local.jqueryUIMin_js}" target="head-js" />
	<res:useJs value="${res.js.local.datepicker_js}" target="head-js" />
</br>

<table class="machines">
	<tr style="text-align:left">
		<th>Machines:
   	  		 <c:forEach var="ip" items="${model.ips}">&nbsp;[&nbsp;
   	  		<c:choose>
					<c:when test="${model.ipAddress eq ip}">
						<a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${ip}"
							class="current">${ip}</a>
					</c:when>
					<c:otherwise>
						<a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${ip}">${ip}</a>
					</c:otherwise>
				</c:choose>
   	 		&nbsp;]&nbsp;
			 </c:forEach>
		</th>
	</tr>
</table>
<br>
<table class="transaction">
	<c:choose>
		<c:when test="${empty payload.type}">
		<tr><th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&sort=type">Type</a></th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&sort=total">Total Count</a></th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&sort=failure">Failure Count</a></th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&sort=failurePercent">Failure%</a></th>
			<th>Sample Link</th><th>Min(ms)</th><th>Max(ms)</th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&sort=avg">Avg</a>(ms)</th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&sort=95line">95Line</a>(ms)</th>
			<th>Std(ms)</th><th>TPS</th></tr>
			<c:forEach var="item" items="${model.displayTypeReport.results}" varStatus="status">
				<c:set var="e" value="${item.detail}"/>
				<c:set var="lastIndex" value="${status.index}"/>
				<tr class="${status.index mod 2 != 0 ? 'odd' : 'even'}">
					<td style="text-align:left"><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${item.type}">${item.type}</a></td>
					<td>${e.totalCount}</td>
					<td>${e.failCount}</td>
					<td>${w:format(e.failPercent,'0.00')}</td>
					<td><a href="${model.logViewBaseUri}/${empty e.failMessageUrl ? e.successMessageUrl : e.failMessageUrl}">Log View</a></td>
					<td>${w:format(e.min,'0.#')}</td>
					<td>${w:format(e.max,'0.#')}</td>
					<td>${w:format(e.avg,'0.0')}</td>
					<td>${w:format(e.line95Value,'0.0')}</td>
					<td>${w:format(e.std,'0.0')}</td>
					<td>${w:format(e.tps,'0.0')}</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
			<th>
			<a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${payload.type}&sort=type">Name</a></th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${payload.type}&sort=total">Total Count</a></th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${payload.type}&sort=failure">Failure Count</a></th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${payload.type}&sort=failurePercent">Failure%</a></th>
			<th>Sample Link</th><th>Min(ms)</th><th>Max(ms)</th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${payload.type}&sort=avg">Avg</a>(ms)</th>
			<th><a href="?op=history&domain=${model.domain}&startDate=${model.startDate}&endDate=${model.endDate}&ip=${model.ipAddress}&type=${payload.type}&sort=95line">95Line</a>(ms)</th>
			<th>Std(ms)</th><th>TPS</th></tr>
			<c:forEach var="item" items="${model.displayNameReport.results}" varStatus="status">
				<c:set var="e" value="${item.detail}"/>
				<c:set var="lastIndex" value="${status.index}"/>
				<tr class="${status.index mod 2 != 0 ? 'odd' : 'even'}">
					<td style="text-align:left">${e.id}</td>
					<td>${e.totalCount}</td>
					<td>${e.failCount}</td>
					<td>${w:format(e.failPercent,'0.00')}</td>
					<td><a href="${model.logViewBaseUri}/${empty e.failMessageUrl ? e.successMessageUrl : e.failMessageUrl}">Log View</a></td>
					<td>${w:format(e.min,'0.#')}</td>
					<td>${w:format(e.max,'0.#')}</td>
					<td>${w:format(e.avg,'0.0')}</td>
					<td>${w:format(e.line95Value,'0.0')}</td>
					<td>${w:format(e.std,'0.0')}</td>
					<td>${w:format(e.tps,'0.0')}</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<res:useJs value="${res.js.local.historyReport_js}" target="bottom-js" />
</jsp:body>

</a:historyReport>