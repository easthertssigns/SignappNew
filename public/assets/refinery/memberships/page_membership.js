$(function(){function e(){$('#role_allow_members_of input[type!="radio"]').attr("disabled",!$("#page_roles #allow_members_of").is(":checked")),$("#role_allow_members_of .role label").css("color",$("#page_roles #allow_members_of").is(":checked")?"":"#999"),$('#role_allow_all_members input[type="hidden"]').attr("disabled",!$("#page_roles #allow_all_members").is(":checked")),$('#role_allow_everyone input[type="hidden"]').attr("disabled",!$("#page_roles #allow_everyone").is(":checked"))}$("#page_roles").corner("tr 5px").corner("bottom 5px"),$("#role_allow_members_of .role label").click(function(e){$("#page_roles #allow_members_of").is(":checked")||e.preventDefault()}),$('#page_roles input[type="radio"]').click(e),e()});