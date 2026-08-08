---

layout: home
title: GMRoomLoader Documentation
titleTemplate: false
description: Documentation for GMRoomLoader, an award-winning GameMaker library for making room prefabs and loading room contents at runtime.

hero:
  name: "GMRoomLoader"
  text: Runtime room loading for GameMaker
  tagline: Room prefabs and runtime content loading made effortless with GMRoomLoader's robust interface.
  actions:
    - theme: brand
      text: What is GMRoomLoader?
      link: '/pages/home/whatIsIt'
    - theme: alt
      text: Get Started
      link: '/pages/home/gettingStarted/gettingStarted'
  image:
    src: /logo.png
    alt: Icon

features:
  - title: 🗺️ Procedural Generation
    details: Create reusable level templates for rooms, NPCs or props, and place them procedurally throughout your levels.
  - title: 🧩 Chunking
    details: Divide large worlds into smaller chunks that dynamically load when players approach and unload when they move away.
  - title: 🏗️ Flexible Loading
    details: Load Full Rooms, Instances or Tilemaps at any position in the current room; all with optional origin, filtering, scaling and rotation.
  - title: 📐 Fluent State Management
    details: Configure optional arguments before loading or screenshotting in a simple English-like flow via the Fluent State Builder.
  - title: ⚙️ Full Lifecycle Control
    details: From merging or creating new layers to Payload tracking and removing loaded elements, you have full control of the loading process.
  - title: 🖼️ Screenshots
    details: Capture room Screenshots from anywhere, without ever visiting target rooms; with optional part definition, scaling and filtering.

---

<hr style="border: none; border-top: 2px solid #888; margin:4em 0 1em;" />

<h2 style="text-align:center; border-top: none; padding-top: 0; margin-top: 0;">GameMaker Awards</h2>

<p style="text-align:center;">GMRoomLoader won Best Tool at the <a href="https://gamemaker.io/en/blog/gamemaker-awards-2025">2025 GameMaker Awards</a>, after being <a href="https://gamemaker.io/en/blog/gamemaker-awards-2024-winners">nominated</a> the year before.</p>

<div style="display:flex;gap:12px;align-items:center;margin-top:1em;">
  <img src="https://github.com/user-attachments/assets/9b2dee65-a891-4d88-8025-3dffb4549213" alt="2025 Award" style="flex:1.784 1 0;width:0;height:auto;">
  <img src="https://github.com/user-attachments/assets/751e1808-4738-4233-86ba-8d9a373ab2a8" alt="Trophy" style="flex:0.75 1 0;width:0;height:auto;">
  <img src="https://github.com/user-attachments/assets/9f24ea91-21da-4f2c-9427-f8ab9cfb778d" alt="2024 Award" style="flex:1.784 1 0;width:0;height:auto;">
</div>

<hr style="border: none; border-top: 2px solid #888; margin:4em 0 1em;" />

<h2 style="text-align:center; border-top: none; padding-top: 0; margin-top: 0;">Tutorials</h2>

<p style="text-align:center;">New to GMRoomLoader? These are a great place to start.</p>

<div style="display:flex;gap:12px;align-items:flex-start;margin-top:1em;">
  <div style="flex:1 1 0;width:0;">
    <div style="position:relative;width:100%;padding-top:56.25%;">
      <iframe src="https://www.youtube.com/embed/gUlcha0e7Hg" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="YouTube video player" frameborder="0" allow="accelerated-encoding; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
    </div>
    <p style="text-align:center;margin-top:0.75em;"><a href="https://www.youtube.com/@PixelatedPope">Pixelated Pope</a> builds a Spelunky-style procedural dungeon, carving a path of hand-crafted rooms loaded at runtime with GMRoomLoader.</p>
  </div>
  <div style="flex:1 1 0;width:0;">
    <div style="position:relative;width:100%;padding-top:56.25%;">
      <iframe src="https://www.youtube.com/embed/mZegvOC47dw" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="YouTube video player" frameborder="0" allow="accelerated-encoding; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
    </div>
    <p style="text-align:center;margin-top:0.75em;"><a href="https://www.youtube.com/@DragoniteSpam">DragoniteSpam</a> introduces GMRoomLoader basics and goes over a few interesting edge cases.</p>
  </div>
</div>

<hr style="border: none; border-top: 2px solid #888; margin:4em 0 1em;" />

<h2 style="text-align:center; border-top: none; padding-top: 0; margin-top: 0;">GMRoomLoader Team</h2>

<script setup>
import { VPTeamMembers } from 'vitepress/theme'

const team = [
  {
    avatar: 'https://avatars.githubusercontent.com/u/50461722?v=4',
    name: 'Gleb Tsereteli',
    title: 'Developer',
    links: [
      { icon: 'github', link: 'https://github.com/GlebTsereteli' },
      { icon: 'twitter', link: 'https://x.com/GlebTsereteli' },
      { icon: 'bluesky', link: 'https://bsky.app/profile/glebtsereteli.bsky.social' }, 
    ]
  },
  {
    avatar: 'https://avatars.githubusercontent.com/u/159041753?v=4',
    name: 'Kate',
    title: 'Visuals & Demo Levels',
    links: [
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/kate-ivanova22/' },
      { icon: 'instagram', link: 'https://www.instagram.com/k8te_iv' },
    ]
  },
  {
    avatar: 'neeri.jpg',
    name: 'neerikiffu',
    title: 'Logo',
    links: [
      { icon: 'bluesky', link: 'https://bsky.app/profile/neerikiffu.bsky.social' },
    ]
  },
]
</script>

<VPTeamMembers :members="team" />