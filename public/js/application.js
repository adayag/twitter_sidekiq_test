
$(document).ready(function() {

  var wait_image = "<img id='spin-girl' src='http://media.tumblr.com/tumblr_m5i6qrAB5K1qbzjato1_400.gif'/>";

  var wait_message = "<h1 id='wait-head'> Tweets awayyyyyyyyyyyyy!</h1>";

   $('#tweet_id').on('submit', function(event){
      event.preventDefault();
      // alert('alerty');
      var url = $(this).attr('action');
      var tweet = $(this).serialize();

      $.post(url, tweet, function(job_id){
          alert(tweet);
          alert(job_id);
         $('#tweet-list').empty();

         function check_status(job_id){

           $.get('/status/'+ job_id, function(job_status){
              alert('inside get');
              console.log(job_status.status);
               if (job_status.status === true)
               { 
                 $('#tweet_list').empty();
                 $('#tweet_list').append('<h2>complete</h2>');
               }
               else
                {
                    $('#tweet_list').append(wait_message);
                    $('#tweet_list').append(wait_image);
                    setTimeout(function(){
                      check_status(job_id);
                    },1000);
                }
           });
        }

         check_status(job_id);


      });
   });




  // $(form).on('submit', function(event){
  //    event.preventDefault();
  //    $('#tweet-list').empty();

  //    var text = $(this).serialize();
  //    var route = '/';

  //    title.after(wait_message);
  //    title.hide();
  //    form.after(wait_image());
  //    form.hide();

  //    $.post(route, text, function(response) {
  //      $('#tweet-list').append(response);
  //      $('#spin-girl').remove();
  //      form.show();
  //      $('#wait-head').remove();
  //      title.show();

  //    });
  //  });
});


