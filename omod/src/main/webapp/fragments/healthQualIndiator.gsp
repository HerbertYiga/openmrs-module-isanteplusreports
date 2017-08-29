<%
    def indicator = config.indicator
%>
<tr id="${ indicator.getUuid() }" class="indicator">
    <td>
        ${ indicator.getName() }
    </td>
    <td style="text-align: center;">
        <% if (indicator.getOption().isSet()) { %>
            <label style="display:inline-block;">
                ${ indicator.getOption().getLabel() }:
            </label> 
            <select id="${ indicator.getOption().getId() }" name="options" style="display:inline-block; margin: 0; min-width:120px; ">
                <% indicator.getOption().getValues().each { optionValue -> %>
                    <option value="${ optionValue }">
                        ${ optionValue }
                    </option>
                <% } %>
            </select>
        <% } %>
    </td>
    <td style="text-align: center;">
        <div style="display:inline-block">
            <input name="selection" type="checkbox"/>
        </div>
    </td>
</tr>