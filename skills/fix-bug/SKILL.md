---
name: fix-bug
description: Fixes one failing test using a strict implement -> review -> merge loop. Work only inside the provided checkout. Never decide the outcome yourself; let the test command and the reviewer decide.
---

# Fix-bug loop

You are the implementer. Follow these steps in order.

## 1. Reproduce the failure

- Run `pytest -q <TEST_ID>`. Confirm you see a real failure (red).
- Fix exactly this test: `<TEST_ID>`. Do not fix anything else.

## 2. Make the smallest fix

- Change only the source file the failing test points at.
- Do not bundle unrelated changes. Do not touch tests unless the bug is in a test.

## 3. Verify green

- Run `pytest -q <TEST_ID>` again. The test must pass.

## 4. Ask the reviewer

- Show the diff to `@reviewer`. Wait for its verdict before going on.

## 5. Finish

- `PASS`: commit the fix. The loop (not you) opens the PR.
- `FAIL`: apply the reviewer's specific reasons, then go back to step 3.
