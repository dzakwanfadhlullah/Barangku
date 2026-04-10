/**
 * Fetch Stitch screen data (image URL + HTML URL) via the SDK,
 * then download assets using curl -L.
 *
 * Usage:
 *   Option A: set STITCH_API_KEY=<your-key>  &&  node fetch_stitch.mjs
 *   Option B: node fetch_stitch.mjs <your-api-key>
 */

import { stitch, StitchToolClient } from "@google/stitch-sdk";
import { execSync } from "child_process";
import { mkdirSync, existsSync } from "fs";

const PROJECT_ID = "15147750021271444984";
const OUTPUT_DIR = "stitch_output";

const SCREENS = [
  { name: "Masuk", id: "4e28eb3f5fd84674a32ccca8ef15f025" },
];

// Accept API key from CLI argument if provided
const cliApiKey = process.argv[2];
if (cliApiKey) {
  process.env.STITCH_API_KEY = cliApiKey;
}

if (!process.env.STITCH_API_KEY) {
  console.error("ERROR: No STITCH_API_KEY found.");
  console.error("");
  console.error("Usage:");
  console.error("  Option A: $env:STITCH_API_KEY = '<your-key>' ; node fetch_stitch.mjs");
  console.error("  Option B: node fetch_stitch.mjs <your-api-key>");
  console.error("");
  console.error("Get your API key from: https://stitch.withgoogle.com → Settings → API Keys");
  process.exit(1);
}

async function main() {
  // Ensure output directory exists
  if (!existsSync(OUTPUT_DIR)) {
    mkdirSync(OUTPUT_DIR, { recursive: true });
  }

  const project = stitch.project(PROJECT_ID);

  for (const screenDef of SCREENS) {
    console.log(`\n${"=".repeat(60)}`);
    console.log(`Screen: ${screenDef.name} (${screenDef.id})`);
    console.log("=".repeat(60));

    const screen = await project.getScreen(screenDef.id);

    const htmlUrl = await screen.getHtml();
    const imageUrl = await screen.getImage();

    console.log(`\nHTML URL:  ${htmlUrl}`);
    console.log(`Image URL: ${imageUrl}`);

    const safeName = screenDef.name.replace(/\s+/g, "_").toLowerCase();

    // Download HTML
    if (htmlUrl) {
      const htmlPath = `${OUTPUT_DIR}/${safeName}.html`;
      console.log(`\nDownloading HTML → ${htmlPath}`);
      try {
        execSync(`curl -L -o "${htmlPath}" "${htmlUrl}"`, { stdio: "inherit" });
        console.log(`  ✓ HTML saved`);
      } catch (e) {
        console.error(`  ✗ HTML download failed:`, e.message);
      }
    }

    // Download Image
    if (imageUrl) {
      const imgPath = `${OUTPUT_DIR}/${safeName}.png`;
      console.log(`Downloading Image → ${imgPath}`);
      try {
        execSync(`curl -L -o "${imgPath}" "${imageUrl}"`, { stdio: "inherit" });
        console.log(`  ✓ Image saved`);
      } catch (e) {
        console.error(`  ✗ Image download failed:`, e.message);
      }
    }
  }

  console.log(`\n${"=".repeat(60)}`);
  console.log(`Done! Assets saved to ./${OUTPUT_DIR}/`);
  console.log("=".repeat(60));
}

main().catch((err) => {
  console.error("Error:", err.message || err);
  process.exit(1);
});
