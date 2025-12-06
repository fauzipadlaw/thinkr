# Thinkr — User Guide

Below is a user-facing guide to using Thinkr. Expand each section to explore the flow.

<details>
<summary>Getting Started</summary>

1. **Sign in**  
   - Choose a method: Google, email/password, or **Continue as guest**.  
   - Captcha may appear only for risky sign-ins; if it doesn’t, you won’t be prompted.  
   - On web, Google redirects to the browser; on mobile it opens the Google sheet—complete auth and return.

2. **Home layout**  
   - Top bar: app logo, language switch (header language icon), logout.  
   - Hero: prompt “What do you want to decide today?”, quick action “New decision”.  
   - Recent decisions preview: tap to open the result (if evaluated) or edit (if not).

</details>

<details>
<summary>Create a Decision</summary>

1. **Open editor**  
   - From Home, tap “New decision”.

2. **Step 1: Method, title & description**  
   - Pick a method: **Weighted Sum**, **AHP**, or **Fuzzy Weighted** (WSM is default; AHP/Fuzzy currently aggregate using the provided weights/scores).  
   - Enter a clear title (required) and optional description.  
   - Cannot proceed without a title.

3. **Step 2: Options**  
   - Add at least 2 options.  
   - You can rename or remove options anytime.

4. **Step 3: Criteria & weights**  
   - Add at least 1 criterion.  
   - Adjust weight (1–10) to show importance.  
   - Remove criteria as needed.

5. **Step 4: Scores matrix**  
   - For each option×criterion, input a score between **1–10**.  
   - Validation blocks you if any score is missing or out of range.

6. **Evaluate**  
   - On the last step, tap “Evaluate”.  
   - A confirmation dialog appears before running evaluation.  
   - Evaluation is remote (Supabase Edge Function for WSM/AHP/Fuzzy); after success you’re routed to the result page.  
   - The decision is saved automatically with its result.

7. **Unsaved changes safeguard**  
   - If you try to navigate back with unsaved edits, you’ll be asked to confirm discarding changes.

</details>

<details>
<summary>Use Templates</summary>

- In the editor, tap a template chip (Career/Product/Travel/Finance).  
- The form pre-fills title, description, options, criteria, and weights.  
- You can edit any pre-filled field before scoring and evaluating.

</details>

<details>
<summary>View Results</summary>

- After evaluation, you land on the **Result** page:  
  - Highlighted best option + score.  
  - Ranking list with scores.  
  - Meta chips: counts of options/criteria and timestamps.  
- If debug data is returned from the Edge Function, it appears at the bottom.

</details>

<details>
<summary>History & Search</summary>

- From Home (recent preview) or “View all history”:  
  - List of past decisions (paginated on web, infinite scroll on mobile).  
  - **Search** by title/description.  
  - Tap a decision:  
    - If evaluated → opens result page.  
    - If not evaluated → opens editor to edit & re-evaluate.  
  - Delete performs a soft delete (removed from list).

</details>

<details>
<summary>Language</summary>

- Tap the language icon in the Home header or go to **Settings** (/app/settings).  
- Choose English or Bahasa Indonesia; the app updates immediately.

</details>

<details>
<summary>Authentication</summary>

- Google Sign-In only (Supabase Auth).  
- Logout via header icon (confirmation dialog).

</details>

<details>
<summary>Scoring Method (WSM)</summary>

- Weighted Sum Model: normalize weights, multiply by scores (1–10), sum per option, rank.  
- Computed on the Supabase Edge Function `evaluate_decision`.

</details>
