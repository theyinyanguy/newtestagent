import ballerina/ai;
import ballerina/mcp;
import ballerinax/ai.openai;

# Toolkit wrapper for an MCP server exposing contract store operations (e.g. fetching contract documents).


// NOTE: Instances of ContractStoreMcpToolkit and SendEmailMcpToolkit are intentionally not
// constructed here. Once the MCP server URLs are available, construct each toolkit, e.g.:
//   final ContractStoreMcpToolkit contractStoreToolkit = check new ("<contract-store-mcp-server-url>");
//   final SendEmailMcpToolkit sendEmailToolkit = check new ("<send-email-mcp-server-url>");
// and add the resulting variables to contractReviewAgent's `tools` array in agents.bal.

final openai:ModelProvider openaiModelprovider = check new (customopenaiAgentManagerKey, "gpt-5-chat-latest", customopenaiAgentManagerUrl);
final ContractStoreMcpToolkit contractStoreMcp = check new (contractStoreMcpUrl);
final SendEmailMockMcpToolkit sendEmailMockMcp = check new (sendEmailMockMcpUrl);
