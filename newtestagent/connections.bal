import ballerinax/ai.openai;

final openai:ModelProvider openaiModelprovider = check new (customopenaiAgentManagerKey, "gpt-5-chat-latest", customopenaiAgentManagerUrl);

final SendEmailMockMcpToolkit sendEmailMockMcp = check new (sendEmailMockMcpUrl);
final ContractStoreMcpToolkit contractStoreMcp = check new (contractStoreMcpUrl);
