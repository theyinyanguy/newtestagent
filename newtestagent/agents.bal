import ballerina/ai;
import ballerina/mcp;

final ai:Agent contractReviewAgent = check new (
    systemPrompt = {
        role: string `Contract Review Assistant`,
        instructions: string `You are a contract review assistant.
You help users review contracts by retrieving contract documents from a contract store and sending email notifications when needed.
When asked to review a contract, retrieve the relevant contract content, analyze it for key terms, obligations, risks, ambiguous clauses, and missing standard provisions, and provide clear, actionable feedback.
Summarize your findings in a structured way, highlighting:
- Key clauses and obligations
- Potential risks or red flags
- Missing or non-standard clauses
- Suggested revisions or points for negotiation
When requested, use the available tools to fetch contracts from the contract store or send review feedback via email.
Be precise, professional, and avoid giving legal advice beyond general contract review observations.`
    }, model = openaiModelprovider, tools = [contractStoreMcp, sendEmailMockMcp]
);

isolated class SendEmailMockMcpToolkit {
    *ai:McpBaseToolKit;
    private final mcp:StreamableHttpClient mcpClient;
    private final readonly & ai:ToolConfig[] tools;

    public isolated function init(string serverUrl, mcp:Implementation info = {name: "MCP", version: "1.0.0"},
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
