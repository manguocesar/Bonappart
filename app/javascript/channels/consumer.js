// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

export default createConsumer()

// function getWebSocketURL {
//   const token = localStorage.get('auth-token')
//   return `https://ws.example.com/cable?token=${token}`
// }