import time

from bs4 import BeautifulSoup
from playwright.sync_api import Playwright, sync_playwright

urls = ["https://www.tokopedia.com/p/komputer-laptop/laptop/macbook"]


def load_html_content(html_content):
    with open(r'web.html', "r", encoding="utf-8") as file:
        html_content = file.read()

    # Load HTML content into BeautifulSoup
    soup = BeautifulSoup(html_content, "html.parser")
    return soup

def parse_data(soup):
    body


def run(playwright: Playwright) -> None:
    browser = playwright.chromium.launch(headless=False, args=["--start-maximized"])
    context = browser.new_context(no_viewport=True)
    page = context.new_page()
    page.goto(urls[0])
    page.wait_for_load_state()
    time.sleep(3)
    while page.locator("nav.css-txlndr-unf-pagination").is_visible() is False:
        page.mouse.wheel(0, 200)
        time.sleep(1)
    web = page.content()
    with open("web.html", "w", encoding="utf-8") as file:
        file.write(web)
    soup = load_html_content(web)
    print(soup.body)
    # ---------------------
    context.close()
    browser.close()


with sync_playwright() as playwright:
    run(playwright)
