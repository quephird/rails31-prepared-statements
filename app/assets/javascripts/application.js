// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
    $('#cached-queries-button').trigger('click') ;

    $(document).delegate('.delete-person-form', 'ajax:success', function() {
        $(this).closest('tr').fadeOut().remove() ;
        $('#cached-queries-button').trigger('click') ;
    });

    $(document).delegate('.edit-person-link', 'click', function() {
        $(this).closest('tr').load($(this).attr('href'));
        return false ;
    });

    $(document).delegate('#cancel-button', 'click', function() {
        $("#person-form-area").html("") ;
        $("#new-person-button").show() ;
    });

    $(document).delegate('#people-filter-form', 'ajax:success', function() {
        $('#cached-queries-button').trigger('click') ;
    });
    $(document).delegate('#filter-cancel-button', 'click', function() {
        $("#filter_last_name").val("") ;
        $("#filter_first_name").val("") ;
        $("#filter_ssn").val("") ;
        $("#filter_age").val("") ;
        $("#person-form-area").html("") ;
    });
}) ;
