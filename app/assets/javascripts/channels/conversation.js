//= require action_cable
//= require_self

// DEFINING THE ACTION CABLE APP
(function() {
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer();
}).call(this);

// CONNECTING THE CHAT CLIENT TO SERVER FUNCTIONALITY
App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    conversation.find('.messages-list').find('ul').append(data['message']);

    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

// MESSAGE SUBMIT CONFIG
$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});

// ALLOWING MESSAGE SUBMISSION WHEN CLICKING ENTER IN THE TEXT AREA
// BUG: CODE CURRENTLY CAUSING ENTER CLICK TO POST EMPTY MESSAGE IN
// EACH OPEN CONVERSATION
// $(function() {
//     $(".text-area").keypress(function (e) {
//         if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
//             $('.send-message').click();
//             return false;
//         } else {
//             return true;
//         }
//     });
// });
