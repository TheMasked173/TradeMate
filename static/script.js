const messages = document.getElementById('messages');
const input = document.getElementById('chat-input');
const sendBtn = document.getElementById('send-btn');

function appendMessage(text, cls='user'){
  const el = document.createElement('div');
  el.className = 'msg ' + cls;
  el.textContent = text;
  messages.appendChild(el);
  // keep scroll to bottom
  messages.parentElement.scrollTop = messages.parentElement.scrollHeight;
}

// Send to backend
async function sendMessage(){
  const text = input.value.trim();
  if(!text) return;
  appendMessage(text, 'user');
  input.value = '';
  appendMessage('…', 'bot'); // placeholder
  const botPlaceholder = messages.querySelector('.msg.bot:last-child');

  try{
    const res = await fetch('/api/chat', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({message: text})
    });
    const data = await res.json();
    botPlaceholder.textContent = data.reply || "Sorry, something went wrong.";
    messages.parentElement.scrollTop = messages.parentElement.scrollHeight;
  } catch(err){
    botPlaceholder.textContent = 'Network error. Try again.';
  }
}

sendBtn.addEventListener('click', sendMessage);
input.addEventListener('keydown', (e)=> {
  if (e.key === 'Enter') sendMessage();
});

// welcome message
appendMessage("Ask me your stock questions!", "bot");
