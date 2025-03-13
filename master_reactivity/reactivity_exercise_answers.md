---
title: "reactivity_exercise_answers"
output: html_document
---

## Part 1.
1. The difference is that the eventReactive() function works with a specific event. The reactive() function is a generic function that work when inputs change.
2. The observeEvent() runs a piece of code for a specific event. The observe() runs a code when anything changes in the UI, so it can be inefficient if we want to observer only a specific change.
3. reactiveValues() can be useful when we want to pass and *store* multiple variables from the UI that might come from different UI elements, and might store different type of values (for example *FirstName*, *LastName*, *Age*, *StreetAddress*, etc.).
   reactive() doesn't store values, so after the event occurs the value(s) will be lost.
4. The values that we intend to use won't be available, and Shiny will send an error message that the variable is outside of the reactive context. (It already happened to me.)
5. Shiny watches events on the client side to occur on the user interface, and - depending on the functions used (i.e. reactive, reactiveEvent, etc.) - this client-side event triggers a server-side action. This can be a calculation, an R function, or a UI element update. The server-side script then sends the changes back to the UI (again, depending on the chosen type of function).

