const config = {
  _id: process.env.MONGO_REPL_ID,
  members: (() => {
    const members = [];

    for (let idx = 0; ; idx += 1) {
      const replica_name = process.env['MONGO_REPL_' + (idx + 1)];
      const host = `${replica_name}:${process.env.MONGO_PORT}`;

      if (!replica_name) {
        console.log(`Replica initialization completed! Total replicas: ${members.length}`);
        return members;
      }

      members.push({ _id: idx, host });
      console.log(`Added replica: ${host}`);
    }
  })()
};

printjson('Replicas:', config);
rs.initiate(config);
