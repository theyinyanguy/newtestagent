import ballerina/ai;
import ballerina/mcp;
import ballerinax/ai.openai;

# Toolkit wrapper for an MCP server exposing contract store operations (e.g. fetching contract documents).
isolated class ContractStoreMcpToolkit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;

    public isolated function init(string serverUrl, mcp:Implementation info = {name: "contract-store-mcp", version: "1.0.0"},
            *mcp:StreamableHttpClientTransportConfig config) returns ai:Error? {
        do {
            self.mcpClient = check new mcp:StreamableHttpClient(serverUrl, config);
            self.tools = check ai:getPermittedMcpToolConfigs(self.mcpClient, info, self.callTool).cloneReadOnly();
        } on fail error e {
            return error ai:Error("Failed to initialize MCP toolkit", e);
        }
    }

    public isolated function getTools() returns ai:ToolConfig[] => self.tools;

    @ai:AgentTool
    public isolated function callTool(mcp:CallToolParams params) returns mcp:CallToolResult|error {
        return self.mcpClient->callTool(params);
    }
}

# Toolkit wrapper for an MCP server exposing a send-email tool.
isolated class SendEmailMcpToolkit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;

    public isolated function init(string serverUrl, mcp:Implementation info = {name: "send-email-mcp", version: "1.0.0"},
            *mcp:StreamableHttpClientTransportConfig config) returns ai:Error? {
        do {
            self.mcpClient = check new mcp:StreamableHttpClient(serverUrl, config);
            self.tools = check ai:getPermittedMcpToolConfigs(self.mcpClient, info, self.callTool).cloneReadOnly();
        } on fail error e {
            return error ai:Error("Failed to initialize MCP toolkit", e);
        }
    }

    public isolated function getTools() returns ai:ToolConfig[] => self.tools;

    @ai:AgentTool
    public isolated function callTool(mcp:CallToolParams params) returns mcp:CallToolResult|error {
        return self.mcpClient->callTool(params);
    }
}

// NOTE: Instances of ContractStoreMcpToolkit and SendEmailMcpToolkit are intentionally not
// constructed here. Once the MCP server URLs are available, construct each toolkit, e.g.:
//   final ContractStoreMcpToolkit contractStoreToolkit = check new ("<contract-store-mcp-server-url>");
//   final SendEmailMcpToolkit sendEmailToolkit = check new ("<send-email-mcp-server-url>");
// and add the resulting variables to contractReviewAgent's `tools` array in agents.bal.

final openai:ModelProvider openaiModelprovider = check new (customopenaiAgentManagerKey, "gpt-5-chat-latest", customopenaiAgentManagerUrl);
final ContractStoreMcpToolkit contractStoreMcp = check new (contractStoreMcpUrl);
final SendEmailMockMcpToolkit sendEmailMockMcp = check new (sendEmailMockMcpUrl);
