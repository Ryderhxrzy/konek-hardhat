// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract messages {
    struct Message {
        address sender;
        string content;
        uint256 timestamp;
    }

    // Mapping to store messages by their ID
    mapping(uint256 => Message) public messages;

    // Counter to keep track of the number of messages
    uint256 public messageCount;

    // Event to emit when a new message is posted
    event MessagePosted(uint256 id, address sender, string content, uint256 timestamp);

    // Function to post a new message
    function postMessage(string memory _content) external {
        messageCount++;
        messages[messageCount] = Message({
            sender: msg.sender,
            content: _content,
            timestamp: block.timestamp
        });
        emit MessagePosted(messageCount, msg.sender, _content, block.timestamp);
    }

    // Function to get a message by its ID
    function getMessage(uint256 _id) external view returns (address, string memory, uint256) {
        Message memory message = messages[_id];
        require(message.sender != address(0), "Message does not exist");
        return (message.sender, message.content, message.timestamp);
    }

    // Function to get the total number of messages
    function getMessageCount() external view returns (uint256) {
        return messageCount;
    }
}