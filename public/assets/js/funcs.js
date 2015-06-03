$(function () {
  $(window).scroll(function () {
    // Get the position of the location where the scroller starts.
    var scroller_anchor = $('.scroller_anchor').offset().top;

    // Check if the user has scrolled and the current position is after the scroller start location and if its not already fixed at the top
    if ($(this).scrollTop() >= scroller_anchor && $('.subnavbar-fixed-top').css('position') != 'fixed')
    {    // Change the CSS of the scroller to hilight it and fix it at the top of the screen.
        $('.subnavbar-fixed-top').css({
            'left': '0',
            'right': '0',
            'position': 'fixed',
            'z-index': '100',
            'top': '0'
        });
        // Changing the height of the scroller anchor to that of scroller so that there is no change in the overall height of the page.
        $('.scroller_anchor').css('height', '50px');
    }
    else if ($(this).scrollTop() < scroller_anchor && $('.subnavbar-fixed-top').css('position') != 'relative')
    {    // If the user has scrolled back to the location above the scroller anchor place it back into the content.

        // Change the height of the scroller anchor to 0 and now we will be adding the scroller back to the content.
        $('.scroller_anchor').css('height', '0px');

        // Change the CSS and put it back to its original position.
        $('.subnavbar-fixed-top').css({
            'position': 'relative'
        });
    }
  });

  $('#add').click(function () {
    $('#add_form').toggle();
    $('#add').remove();
  });


  $('.hint').tooltip();
  // if (location.pathname == "/") {
    // $('.update-callcontroller').tooltip('show');
  // }

  var flst = $('script[src="/vendor/filestyle/js/bootstrap-filestyle.min.js"]').length;
  if (flst !== 0) {
    $(":file").filestyle({input: false, classButton: "btn input-block-level"});
  }

  $(document).ready(function () {
    if (Modernizr.csstransforms3d === false){
      $('.modal').removeClass('fade');
    }
    var hash = window.location.hash;
  });

  $('input,select,textarea').not('[type=submit]').jqBootstrapValidation();
  
});

var parseCampaign = function (campaignid) {
  $.ajax({
    method: "POST",
    url: "/campaign/import",
    data: { campaign_id: campaignid }
  }).done(function() {
    alert( "success" );
  })
  .fail(function() {
    alert( "error" );
  })
  .always(function() {
    alert( "complete" );
  });
  
}

var passDataToModal = function (data, modal_id) {
  $(".modal-body #dataInput").text(data[0]);
  $(".modal-body #dataInput").val(data[0]);
  if (data[1] == '1') {
    $(".modal-body #dataCheckbox").prop( "checked", true );
  } else {
    $(".modal-body #dataCheckbox").prop( "checked", false );
  }
  $(".modal-body #email").text(data[2]);
  $(".modal-body #email").val(data[2]);
  
  $(".modal-body #first_name").text(data[3]);
  $(".modal-body #first_name").val(data[3]);
  
  $(".modal-body #last_name").text(data[4]);
  $(".modal-body #last_name").val(data[4]);
  
  $(".modal-footer #dataInput").val(data[0]);
  $(modal_id).modal('show');
};

var editRole = function (name) {
  $.get('/role/edit/' + name, function (data) {
    $('#roleeditor').html(data);
    $('#editRole').modal('show');
  });
};

var getTaskNotifications = function (task_id, refreshing) {
  if (typeof(refreshing)==='undefined') refreshing = false;
  $.get('/notifications/bytask/' + task_id, function (data) {
    var accordions = [];
    $( ".accordion-body" ).each( function( index ) {
      if ($( this ).attr('id') !== "nocollapse"){
        accordions[index] = $( this ).attr('class');
      }
    });
    $('#taskNotifications').html(data);
    for (var index in accordions){
      $( ".accordion-body" ).eq(index).attr('class', accordions[index]);
    }
    if ( document.getElementById("finished") !== null ){
      if ( refreshing ){
        location.reload();
      }
    } else {
      var interval = setTimeout(function() { getTaskNotifications(task_id, true); }, 15000);
    }
  });
};

var reloadTasks = function (){
  $.get('/task/list', function (data) {
    var newDoc = $(data).contents();
    currlength = $('#active tr').length;
    if ( $('#active tr .dataTables_empty').length !== 0 ) {
      currlength = 0;
    }
    if ( currlength !== newDoc.find("#active tr").length ){
      location.reload();
    }
  });
};

var delTask = function (id) {
  $.get('/task/del/' + id, function (data) {
    location.reload();
  });
};

// TODO: Make the backend return a json element so we can replace everything on the fly instead of simply readding elements
var addRoleMember = function (role) {
  var username = $('#selectAddUser').val();
  $.post('/role/add-member', {
    role: role,
    username: username
  }, function () {
    $('#roleMembers').append('<div class="input-append" id="' + username + '"><span class="add-on" style="width: 78px;">' + username + '</span><button class="btn" type="button" onclick="delRoleMember(\'' + role + '\', \'' + username + '\')"><i class="icon-minus"></i></button></div>');
    $('#selectAddUser').find('option[value="' + username + '"]').remove();
    // e.removeChild(e.options[e.selectedIndex]);
  });
};

var delRoleMember = function (role, username) {
  $.post('/role/del-member', {
    role: role,
    username: username
  }, function () {
    $('#' + username).remove();
    $('#selectAddUser').append('<option value="' + username + '">' + username + '</option>');
  });
};

var dismissNotification = function (msg_id) {
  $.post('/notification/dismiss', {
    msg_id: msg_id
  }, function () {

  });
};

var dismissMonitoringNotification = function (msg_id) {
  $.post('/notification/monitoring/dismiss', {
    msg_id: msg_id
  }, function () {
    $('#' + msg_id).remove();
  });
};

var load_spinner = function () {
  $('body').append( '<div class="spinner-container"><div class="spinner"></div></div>' );
};
