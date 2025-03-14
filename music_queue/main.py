import threading
import time
from music_queue.music_queue import create_app, poll_inference_queue
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = create_app()

if __name__ == "__main__":
    port = os.getenv("MUSIC_QUEUE_PORT", "5001")
    logger.info("--------|diskrot|---------")
    logger.info(f"Starting Music Queue on port {port}")

    def start_polling():
        while True:
            poll_inference_queue()
            time.sleep(5)

    threading.Thread(target=start_polling, daemon=True).start()

    app.run(debug=True, host="0.0.0.0", port=5001)
