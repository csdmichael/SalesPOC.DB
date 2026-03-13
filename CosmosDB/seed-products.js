require("dotenv").config();
const { CosmosClient } = require("@azure/cosmos");

// 🔹 CONFIGURE THESE via .env file
const endpoint = process.env.COSMOS_ENDPOINT;
const key = process.env.COSMOS_KEY;
const databaseId = process.env.COSMOS_DATABASE || "sales";
const containerId = process.env.COSMOS_CONTAINER || "products";

// Product dimensions
const categories = ["MCU", "ASIC", "FPGA", "Power IC", "Sensor", "RF"];
const nodes = [5, 7, 14, 28, 40, 65];
const markets = ["Automotive", "Industrial", "IoT", "Datacenter", "Consumer"];

const client = new CosmosClient({ endpoint, key });

async function seedProducts() {
  const container = client
    .database(databaseId)
    .container(containerId);

  for (let i = 1; i <= 200; i++) {
    const category = categories[i % categories.length];
    const node = nodes[i % nodes.length];
    const market = markets[i % markets.length];

    const item = {
      id: `chip-${i}`,
      description: `Chip-${i} is a ${category} semiconductor device built on a ${node}nm process node. 
It is optimized for ${market.toLowerCase()} applications requiring high performance, power efficiency, 
and long-term reliability. Chip-${i} supports industrial-grade temperature ranges and is designed 
for scalable system architectures and long lifecycle deployments.`
    };

    await container.items.create(item);
    console.log(`Inserted ${item.id}`);
  }

  console.log("✅ Successfully inserted 200 product overviews");
}

seedProducts().catch(console.error);
