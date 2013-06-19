<%
	config.require("searchType")

	ui.includeJavascript("kenyaui", "coreFragments.js")
%>
<input type="hidden" id="${ config.id }" name="${ config.formFieldName }" class="ke-search" data-searchtype="${ config.searchType }" <% if (config.initialValue) {%> value="${ config.initialValue.id }"<% } %> />
<span id="${ config.id }-error" class="error" style="display: none"></span>
<% if (config.parentFormId) { %>
<script type="text/javascript">
	jq(function() {
		jq('#${ config.id }').data('default-value', jq('#${ config.id }').val());

		subscribe('${ config.parentFormId }.reset', function() {
			kenyaui.updateSearchDisplay('${ config.id }', jq('#${ config.id }').data('default-value'));
		});

		subscribe('${ config.parentFormId }.clear-errors', function() {
			jq('#${ config.id }-error').html('').hide();
		});

		subscribe('${ config.parentFormId }/${ config.formFieldName }.show-errors', function(message, payload) {
			FieldUtils.showErrorList('${ config.id }-error', payload);
		});

		jq('#${ config.id }').change(function() {
			publish('${ config.parentFormId }/changed');
		});
	});
</script>
<% } %>