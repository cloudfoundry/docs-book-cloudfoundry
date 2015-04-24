google.setOnLoadCallback(function() {
  var customSearchOptions = {};
  var customSearchControl = new google.search.CustomSearchControl(
    '005804290371689664731:9jhxguhn8dy', customSearchOptions);

  $('.gsc-results-close-btn').click(function () {
     $('#search-dropdown-box').hide();
  });

  $('#search-dropdown-box input.gsc-input:not(.placeholder)').val('What do you want to find, build, create or do?').addClass('placeholder');

  $('#search-dropdown-box input.gsc-input').bind('focus', function(){
     if ($(this).val() == 'What do you want to find, build, create or do?'){
        $(this).val('');
     }
     }).bind('blur', function(){
       if ($(this).val() === ''){
          $(this).val('What do you want to find, build, create or do?');
       }
  });

  $('#docs-search input.gsc-input:not(.placeholder)').val('Search Documentation').addClass('placeholder');

  $('#docs-search input.gsc-input').bind('focus', function(){
     if ($(this).val() == 'Search Documentation'){
        $(this).val('more:documentation ');
     }
     }).bind('blur', function(){
       if ($(this).val() === 'more:documentation '){
          $(this).val('Search Documentation');
       }
    });
}, true);