# Playdate Art Explorer

An interactive game that brings children's artwork to life on the Playdate console.

## Overview
Transform scanned artwork into explorable game worlds where players can navigate through the drawings, discover secrets, and collect items while experiencing the art in a new dimension.

## Development Status
Currently in Phase 1: Basic Mechanics
- [x] Player movement
- [x] Basic collectibles
- [ ] Jumping mechanics
- [ ] Platform collision

## Development Roadmap

### Phase 1: Core Mechanics
- Add jumping physics
- Implement solid platform collision
- Add basic sound effects
- Create level boundaries

### Phase 2: Artwork Integration
- Set up artwork processing pipeline
- Create first playable art level
- Add interactive elements from the drawings
- Implement collision maps

### Phase 3: Enhanced Gameplay
- Scene transitions
- Special abilities
- Score system
- Sound effects
- Hidden secrets

### Phase 4: Polish
- Menu system
- Save progress
- Achievements
- Visual effects

## Art Integration Guide

### Preparing Artwork
1. Select drawings with:
   - High contrast elements
   - Interesting shapes/patterns
   - Potential platforms/obstacles
   - Clear focal points

2. Scanning Process:
   - Resolution: 400x240 (Playdate screen size)
   - High contrast settings
   - Clean white background
   - Save as PNG

3. Image Processing:
   - Convert to 1-bit black/white
   - Clean up noise/artifacts
   - Mark collision areas
   - Identify interactive elements

### Level Design Tips
- Use natural shapes as platforms
- Create hidden paths through the artwork
- Place collectibles in interesting locations
- Add interactive elements from the drawings
- Design connected layouts between scenes
