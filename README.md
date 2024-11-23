# LLM-researcher-old

## Description
LLM-researcher-old is an innovative research assistant that leverages locally-run large language models through Ollama to conduct automated online research on any given topic or question. Unlike traditional LLM interactions, this tool actually performs structured research by breaking down queries into focused research areas, systematically investigating via web searching and then scraping of relevant websites each area, and compiling it's findings all saved automatically into a text document with all content found and links for the source of each.

## Here's how it works:

1. You provide a research query (e.g., "What year will global population begin to decrease rather than increase according to research?")
2. The LLM analyzes your query and generates 5 specific research focus areas, each with assigned priorities based on relevance to the topic or question.
3. Starting with the highest priority area, the LLM:
   - Formulates targeted search queries
   - Performs web searches
   - Analyzes search results selecting the most relevant web pages
   - Scrapes and extracts relevant information for selected web pages
   - Documents all content it has found during the research session into a research text file including links to websites that the content was retrieved from
4. After investigating all focus areas, the LLM based on information is found generates new focus areas, and repeating it's research cycle, often finding new relevant focus areas based on findings in research it has previously found leading to interesting and novel research focuses in some cases.
5. You can let it research as long as you would like at any time being able to input a quit command which then stops the research and causes the LLM to review all the content collected so far in full and generate a comprehensive summary to respond to your original query or topic. 
6. Then the LLM will enter a conversation mode where you can ask specific questions about the research findings if desired.

The key distinction is that this isn't just a chatbot - it's an automated research assistant that methodically investigates topics and maintains a documented research trail all from a single question or topic of your choosing, and depending on your system and model can do over a hundred searches and content retrievals in a relatively short amount of time, you can leave it running and come back to a full text document with over a hundred pieces of content from relevant websites, and then have it summarise the findings and then even ask it questions about what it found.

## Features
- Automated research planning with prioritized focus areas
- Systematic web searching and content analysis
- All research content and source URLs saved into a detailed text document
- Research summary generation
- Post-research Q&A capability about findings
- Self-improving search mechanism
- Rich console output with status indicators
- Comprehensive answer synthesis using web-sourced information
- Research conversation mode for exploring findings

## Installation

### 1. Clone the repository and cd into the project root

```sh
git clone https://github.com/synth-mania/LLM-researcher-old
cd LLM-researcher-old
```

### 2. Install and Configure Ollama
- Install Ollama following instructions at https://ollama.ai
- Using your selected model file, create a custom model variant with the required context length
  (phi3:3.8b-mini-128k-instruct or phi3:14b-medium-128k-instruct are recommended)

Create a file named `modelfile` with these exact contents:

```
FROM your-model-name
PARAMETER num_ctx 38000
```

Replace "your-model-name" with your chosen model (e.g., phi3:3.8b-mini-128k-instruct).

Then create the model:

```sh
ollama create research-phi3 -f modelfile
```

Note: This specific configuration is necessary as recent Ollama versions have reduced context windows on models like phi3:3.8b-mini-128k-instruct despite the name suggesing high context which is why the modelfile step is necessary due to the high amount of information being used during the research process. 

### 3. edit src/LLM-config.py with your model name

Notice how model_name is the same as the name we gave it with the ollama create command above.

```python
LLM_CONFIG_OLLAMA = {
    "llm_type": "ollama",
    "base_url": "http://localhost:11434",  # default Ollama server URL
    "model_name": "researcher",  # Replace with your Ollama model name
    "temperature": 0.7,
    "top_p": 0.9,
    "n_ctx": 55000,
    "context_length": 55000,
    "stop": ["User:", "\n\n"]
}

```

## Usage

### 1. Start Ollama

Execute this in it's own terminal. Closing that terminal will stop Ollama.

```sh
ollama serve
```

### 2. Run the researcher

Open a terminal window and navigate to the project root directory, then execute the following command:


```sh
./start.sh
```

### 3. Start a research session
- Type `@` followed by your research query
- Press CTRL+D to submit
- Example: `@What year is global population projected to start declining?`

### 4. During research you can use the following commands by typing the letter associated with each and submitting with CTRL+D:
- Use `s` to show status.
- Use `f` to show current focus.
- Use `p` to pause and assess research progress, which will give you an assessment from the LLM after reviewing the entire research content whether it can answer your query or not with the content it has so far collected, then it waits for you to input one of two commands, `c` to continue with the research or `q` to terminate it which will result in a summary like if you terminated it without using the pause feature.
- Use `q` to quit research.

### 5. After research completes:
- Wait for the summary to be generated, and review the LLM's findings.
- Enter conversation mode to ask specific questions about the findings.
- Access the detailed research content found, avaliable in the in a research session text file which will appear in the programs directory, which includes:
  * All retrieved content
  * Source URLs for all information
  * Focus areas investigated
  * Generated summary

## Configuration

The LLM settings can be modified in `llm_config.py`. You must specify your model name in the configuration for the researcher to function. The default configuration is optimized for research tasks with the specified Phi-3 model.

## Current Status
This is a prototype that demonstrates functional automated research capabilities. While still in development, it successfully performs structured research tasks. Currently tested and working well with the phi3:3.8b-mini-128k-instruct model when the context is set as advised previously.

## Dependencies
- Ollama
- Python packages listed in requirements.txt
- Recommended model: phi3:3.8b-mini-128k-instruct or phi3:14b-medium-128k-instruct (with custom context length as specified)
Make sure you have gcc and g++, for the dependencies in requirements.txt to compile properly.

## Contributing
Contributions are welcome! This is a prototype with room for improvements and new features.

## License
This project is licensed under the MIT License - see the [LICENSE] file for details.

## Acknowledgments
- Ollama team for their local LLM runtime
- DuckDuckGo for their search API
- James Warburton (i.e. TheBlewish) for initially creating this project

## Disclaimer
This project is for educational purposes only. Ensure you comply with the terms of service of all APIs and services used.
