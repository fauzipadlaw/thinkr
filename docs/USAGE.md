# Thinkr — User Guide

Below is a user-facing guide to using Thinkr. Expand each section to explore the flow.

<details>
<summary>Getting Started</summary>

1. **Sign in**  
   - Choose from three authentication methods:
     - **Email & Password**: Sign up with a new account or sign in to an existing one
     - **Google Sign-In**: Quick OAuth authentication (web redirects to browser; mobile opens Google sheet—complete auth and return)
     - **Continue as Guest**: Anonymous sign-in for trying the app without an account
   - Captcha may appear only when enabled in Supabase and for risky sign-ins; if it's not configured or not needed, you won't be prompted
   - Password requirements: minimum 6 characters
   - Form validation prevents submission with invalid email or missing required fields

2. **Home layout**  
   - Top bar: app logo, language switch (header language icon), logout button
   - Hero section: prompt "What do you want to decide today?" with quick action "New decision"
   - Recent decisions preview: shows your latest decisions—tap to open the result (if evaluated) or edit (if not yet evaluated)
   - "See all history" link to view complete decision history

3. **Documentation access**  
   - Access this user guide anytime via the documentation icon (book icon) on the login page or from within the app

</details>

<details>
<summary>Create a Decision</summary>

1. **Open editor**  
   - From Home, tap "New decision" to start the decision-making process

2. **Step 1: Method, title & description**  
   - **Choose a decision method**:
     - **Weighted Sum Model (WSM)**: Best for quick scoring—uses your weights and 1–10 scores to rank options. Simple and intuitive.
     - **AHP (Analytic Hierarchy Process)**: Supports pairwise comparisons for more precise weight determination. Reports consistency ratio (CR) to validate your comparisons. Without pairwise data, falls back to using your direct weights.
     - **Fuzzy Weighted Sum**: Handles uncertainty by representing each score as a triangular fuzzy number with spread. Good when scores are approximate or uncertain.
   - Enter a clear **title** (required)—this helps you identify the decision later
   - Add an optional **description** to provide context or constraints
   - Cannot proceed without a title

3. **Step 2: Options**  
   - Add at least **2 options** to compare
   - Each option represents a choice you're considering
   - You can rename or remove options anytime
   - Validation will prevent you from proceeding with fewer than 2 options

4. **Step 3: Criteria & weights**  
   - Add at least **1 criterion** (what matters in your decision)
   - Adjust weight for each criterion (1–10 scale) to show relative importance
   - Weights are automatically normalized, so focus on relative values
   - Remove criteria as needed
   - For **AHP method**: optionally use pairwise comparisons to determine weights more precisely using a 3-point scale (Equal/Moderate/Strong)

5. **Step 4: Scores matrix**  
   - For each option×criterion combination, input a score between **1–10**
   - Scores represent how well each option performs on each criterion
   - Empty scores are treated as 0 (but validation will warn you)
   - Validation blocks evaluation if:
     - Any score is outside the 1–10 range
     - Required fields are missing
   - You'll see a warning message showing how many scores are still empty

6. **Templates (optional)**  
   - Use pre-built templates to get started quickly:
     - **Career Move**: Compare staying, switching companies, or going freelance (criteria: compensation, growth, work-life balance, stability)
     - **Product Decision**: Build vs buy vs open-source (criteria: cost, speed, scalability, support)
     - **Travel Plan**: Beach vs city vs nature trips (criteria: budget, activities, weather, travel time)
     - **Financial Move**: Index funds vs real estate vs cash (criteria: risk, return, liquidity, time horizon)
   - Templates pre-fill title, description, options, criteria, and weights
   - You can edit any pre-filled field before scoring and evaluating

7. **Evaluate**  
   - On the last step, tap "Evaluate" when all scores are complete
   - A confirmation dialog appears before running the evaluation
   - Evaluation is performed remotely via Supabase Edge Function
   - After successful evaluation, you're automatically routed to the result page
   - The decision and its result are saved automatically

8. **Unsaved changes safeguard**  
   - If you try to navigate back or switch between sign-in/sign-up with unsaved edits, you'll be asked to confirm discarding changes
   - This prevents accidental loss of your work

</details>

<details>
<summary>View Results</summary>

After evaluation, you land on the **Result** page with comprehensive information:

1. **Best Option**  
   - Clearly highlighted winner with its final score
   - This is the recommended choice based on your weights and scores

2. **Ranking List**  
   - All options ranked from best to worst
   - Each option shows its calculated score

3. **Reliability Indicator**  
   - Shows how confident you can be in the result:
     - **High**: Strong confidence—clear winner with good margin
     - **Moderate**: Reasonable confidence—winner is ahead but not by much
     - **Low**: Weak confidence—results are close, consider reviewing
     - **Very Low**: Very uncertain—top options are nearly tied
   - Reliability combines multiple factors: score margin, weight stability, and (for fuzzy) overlap

4. **Method-Specific Metrics**  
   - **Stability**: Shows if the best option remains #1 when weights are slightly perturbed (0.0–1.0, higher is better)
   - **AHP Consistency Ratio (CR)**: For AHP method with pairwise comparisons—measures consistency of your comparisons (aim for CR < 0.1)
   - **Fuzzy Overlap**: For Fuzzy method—shows how much the top fuzzy scores overlap (lower overlap = clearer winner)

5. **How to Read This (Notes)**  
   - Expandable section explaining each metric:
     - **Reliability**: Mixes score margin, weight stability, and (for fuzzy) overlap; higher means more trustworthy
     - **Stability**: Simulates small weight tweaks; if the best option stays #1, the result is stable
     - **Fuzzy Overlap**: Shows how much the top fuzzy scores overlap; lower overlap = clearer winner
     - **AHP CR**: Checks consistency of pairwise comparisons; aim for CR < 0.1 for reliable results

6. **Metadata**  
   - Chips showing: number of options, number of criteria, creation timestamp, last updated timestamp

7. **Debug Data**  
   - If returned from the Edge Function, detailed calculation data appears at the bottom
   - Useful for understanding exactly how the result was computed

</details>

<details>
<summary>History & Search</summary>

Access your saved decisions from the Home page or dedicated History page:

1. **View History**  
   - From Home: see recent decisions in the preview section
   - Tap "See all history" to view complete list
   - **Web**: Paginated list for easy navigation
   - **Mobile**: Infinite scroll for seamless browsing

2. **Search Functionality**  
   - Search by title or description
   - Quickly find specific decisions from your history

3. **Interact with Decisions**  
   - Tap any decision card:
     - **If evaluated**: Opens the result page to review the outcome
     - **If not evaluated**: Opens the editor to complete scoring and evaluate
   - Each card shows:
     - Title and description
     - Number of options and criteria
     - Best option (if evaluated)
     - Timestamps

4. **Delete Decisions**  
   - Delete button performs a soft delete
   - Removed from your list but not permanently destroyed
   - Helps keep your history organized

</details>

<details>
<summary>Language</summary>

Thinkr supports multiple languages with instant switching:

1. **Change Language**  
   - Tap the language icon in the Home header, or
   - Go to **Settings** page (/app/settings)
   - Choose between:
     - **English**
     - **Bahasa Indonesia**
   - The app updates immediately without restart
   - Language preference is saved for future sessions

2. **Localized Content**  
   - All UI elements, messages, and templates are fully localized
   - Error messages and validation appear in your selected language

</details>

<details>
<summary>Authentication</summary>

Thinkr offers flexible authentication options:

1. **Sign-In Methods**  
   - **Email & Password**: Traditional account creation and sign-in
     - Sign up: requires email, password (min 6 chars), and password confirmation
     - Sign in: email and password
     - Form validation ensures data integrity
   - **Google Sign-In**: OAuth authentication via Supabase Auth
     - Web: redirects to Google in browser
     - Mobile: opens Google authentication sheet
   - **Guest/Anonymous**: Try the app without creating an account
     - Quick access to all features
     - Data is saved to your anonymous session

2. **Captcha (Optional)**  
   - Appears only when enabled in Supabase configuration
   - Triggered for risky sign-in attempts
   - Uses hCaptcha for verification
   - If not configured, you won't see captcha prompts

3. **Logout**  
   - Tap logout icon in the header
   - Confirmation dialog prevents accidental logout
   - Returns you to the login page

4. **Session Management**  
   - Sessions are managed by Supabase Auth
   - Automatic token refresh keeps you signed in
   - Protected routes redirect to login when not authenticated

</details>

<details>
<summary>Decision Methods Explained</summary>

Thinkr supports three decision-making methods, each suited for different scenarios:

### Weighted Sum Model (WSM)

**Best for**: Quick decisions with straightforward scoring

**How it works**:
1. Normalize criterion weights: `w_i_normalized = w_i / Σ w_i`
2. Calculate score per option: `score(option) = Σ (w_i_normalized × score(option, criterion_i))`
3. Rank options by total score (highest wins)

**Reliability calculation**:
- **Margin**: Difference between best and second-best scores (larger margin = more reliable)
- **Stability**: Tests if the best option remains #1 when weights are slightly varied (64 random perturbations)
- **Combined**: `reliability = 0.7 × margin + 0.3 × stability`
- **Error rate**: `1 - reliability`

**When to use**: 
- You have clear, numeric scores for each option
- Weights are straightforward to assign
- You want quick, intuitive results

### AHP (Analytic Hierarchy Process)

**Best for**: Complex decisions requiring precise weight determination

**How it works**:
1. **With pairwise comparisons**: 
   - Compare each pair of criteria using a 3-point scale (Equal/Moderate/Strong)
   - System derives optimal weights from your comparisons
   - Calculates Consistency Ratio (CR) to validate your comparisons
   - Aim for CR < 0.1 for reliable results
2. **Without pairwise comparisons**: Falls back to using your direct weights (like WSM)
3. Aggregates scores using derived or direct weights
4. Ranks options by total score

**Consistency Ratio (CR)**:
- Measures how consistent your pairwise comparisons are
- CR < 0.1: Excellent consistency
- CR 0.1–0.2: Acceptable consistency
- CR > 0.2: Inconsistent—review your comparisons

**When to use**:
- You need to determine precise relative importance of criteria
- You can make pairwise comparisons more easily than assigning absolute weights
- You want validation of your judgment consistency

### Fuzzy Weighted Sum

**Best for**: Decisions with uncertain or approximate scores

**How it works**:
1. Each score is represented as a triangular fuzzy number: `(a, b, c)` where:
   - `a = score - spread` (lower bound)
   - `b = score` (most likely value)
   - `c = score + spread` (upper bound)
2. Fuzzy arithmetic is used for all calculations (multiplication and addition)
3. Final scores are defuzzified using centroid method: `(a + b + c) / 3`
4. Options are ranked by defuzzified scores

**Spread parameter**:
- Default: 1.0
- Larger spread = more uncertainty in your scores
- Smaller spread = more confidence in your scores

**Reliability calculation**:
- **Margin**: Difference between best and second-best defuzzified scores
- **Stability**: Tests robustness to weight variations
- **Overlap**: Measures how much top fuzzy scores overlap (lower = clearer winner)
- **Combined**: `reliability = 0.5 × margin + 0.2 × stability + 0.3 × (1 - overlap)`

**When to use**:
- Your scores are approximate or uncertain
- You want to model the uncertainty in your judgments
- You need to see how uncertainty affects the final ranking

</details>

<details>
<summary>Understanding Results & Reliability</summary>

### Interpreting Reliability Levels

**High Reliability (≥ 0.75)**
- Strong confidence in the result
- Clear winner with significant margin over other options
- Stable across weight variations
- **Action**: Proceed with confidence

**Moderate Reliability (0.50–0.74)**
- Reasonable confidence in the result
- Winner is ahead but not by a large margin
- Generally stable but some sensitivity to weights
- **Action**: Review if the margin seems too close for comfort

**Low Reliability (0.25–0.49)**
- Weak confidence in the result
- Top options are close in score
- Result may change with small weight adjustments
- **Action**: Consider reviewing your weights and scores, or gathering more information

**Very Low Reliability (< 0.25)**
- Very uncertain result
- Top options are nearly tied
- High sensitivity to weight changes
- **Action**: The decision is too close to call—you may need to:
  - Refine your criteria
  - Adjust weights to reflect true priorities
  - Add more criteria to differentiate options
  - Gather more information before deciding

### What Affects Reliability?

1. **Score Margin**: How far ahead is the winner?
   - Large gap = high reliability
   - Small gap = low reliability

2. **Weight Stability**: Does the winner stay #1 when weights vary slightly?
   - Consistent winner = high stability
   - Winner changes = low stability

3. **Fuzzy Overlap** (Fuzzy method only): How much do top scores overlap?
   - Low overlap = clear separation = high reliability
   - High overlap = unclear winner = low reliability

4. **AHP Consistency** (AHP method only): How consistent are your pairwise comparisons?
   - CR < 0.1 = consistent judgments
   - CR > 0.2 = inconsistent—review your comparisons

### Tips for Better Results

1. **Use appropriate weights**: Make sure weights truly reflect the relative importance of each criterion
2. **Be honest with scores**: Score objectively based on actual performance, not wishful thinking
3. **Add more criteria**: If results are too close, you may need additional criteria to differentiate options
4. **Check stability**: Low stability suggests you need to be more certain about your weights
5. **Review close calls**: When reliability is low, take time to reconsider your inputs
6. **Use the right method**: 
   - WSM for straightforward decisions
   - AHP when you need help determining weights
   - Fuzzy when dealing with uncertainty

</details>

<details>
<summary>Settings</summary>

Access app settings from the Settings page:

1. **Language Selection**  
   - Choose your preferred language
   - Changes apply immediately
   - Affects all UI text, messages, and templates

2. **Future Settings**  
   - Additional preferences may be added in future updates
   - Check this section for new customization options

</details>

<details>
<summary>Tips & Best Practices</summary>

### Creating Effective Decisions

1. **Choose the Right Method**
   - Simple decisions: Use WSM
   - Need help with weights: Use AHP with pairwise comparisons
   - Uncertain scores: Use Fuzzy

2. **Define Clear Criteria**
   - Make criteria specific and measurable
   - Avoid overlapping criteria
   - Include all factors that matter

3. **Assign Meaningful Weights**
   - Reflect true priorities, not what you think you should prioritize
   - Use the full 1–10 range to show differences
   - For AHP: make pairwise comparisons carefully

4. **Score Objectively**
   - Base scores on facts when possible
   - Be consistent in how you score across options
   - Use the full 1–10 range to differentiate

5. **Review Results Critically**
   - Check reliability indicators
   - If reliability is low, review your inputs
   - Consider if the result aligns with your intuition
   - Use debug data to understand the calculation

### Common Pitfalls to Avoid

1. **Too many criteria**: More isn't always better—focus on what truly matters
2. **Equal weights**: If everything is equally important, nothing is—differentiate
3. **Biased scoring**: Don't inflate scores for your preferred option
4. **Ignoring reliability**: Low reliability means the result is uncertain
5. **Not using templates**: Templates can save time and provide structure

</details>
