import consumer from "./consumer";

const initConversationCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.conversationId;
    console.log("Hello")
    consumer.subscriptions.create({ channel: "ConversationChannel", id: id }, {
      received(data) {
        console.log(data)
        messagesContainer.insertAdjacentHTML('beforeend', data);
        // called when data is broadcast in the cable
      },
    });
  }
}

export { initConversationCable };
