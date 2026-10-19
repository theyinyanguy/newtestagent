import ballerina/os;

configurable string customopenaiAgentManagerUrl = os:getEnv("CUSTOMOPENAI_URL");
configurable string customopenaiAgentManagerKey = os:getEnv("CUSTOMOPENAI_API_KEY");
configurable string contractStoreMcpUrl = os:getEnv("CONTRACT_STORE_MCP_URL");
configurable string sendEmailMockMcpUrl = os:getEnv("SEND_EMAIL_MOCK_MCP_URL");
