# NeuroDialogue: AI-Driven Interaction System

A modular interaction framework built in Godot 4.3 demonstrating state-based NPC behavior using GDScript.

## 🚀 Technical Implementation
- **FSM Logic:** Uses a Finite State Machine to transition between Neutral, Friendly, and Hostile states.
- **Signal-Driven UI:** Implements Godot's Observer pattern to decouple UI components from backend logic.
- **Clamped State Math:** Employs mathematical clamping to ensure state stability within defined bounds.

## 🕹️ Interaction Rules
- **Gifts (+2 Affinity):** Moves the NPC toward the 'Friendly' state.
- **Insults (-2 Affinity):** Moves the NPC toward the 'Hostile' state.