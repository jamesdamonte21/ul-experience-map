export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return res.status(500).json({ error: 'API key not configured' });
  }

  const { question, context } = req.body || {};
  if (!question) {
    return res.status(400).json({ error: 'No question provided' });
  }

  const systemPrompt = `You are an expert analyst for the UL Solutions Internal Certification Experience Map.

The experience map documents the end-to-end certification journey across 7 phases. You have access to the full dataset below.

IMPORTANT RULES:
- Base your answers ONLY on the data provided — do not invent or assume anything not in the data
- Always respond with structured bullet points (3–6 bullets max)
- Keep each bullet concise — one clear insight per bullet
- Start with a one-sentence direct answer, then the bullets
- Use plain language suitable for both operational staff and executives

DATA:
${JSON.stringify(context, null, 1)}`;

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
      },
      body: JSON.stringify({
        model: 'claude-haiku-4-5-20251001',
        max_tokens: 1024,
        system: systemPrompt,
        messages: [{ role: 'user', content: question }],
      }),
    });

    if (!response.ok) {
      const err = await response.text();
      return res.status(502).json({ error: 'Anthropic API error', detail: err });
    }

    const data = await response.json();
    const answer = data.content?.[0]?.text || '';
    return res.status(200).json({ answer });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
}
