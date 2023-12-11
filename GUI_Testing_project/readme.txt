Project Title
    GUI Automation Framework using robotframework browser-library
Project Description
    This project aims to demo some of the basic features of GUI-test automation using the Playwright-based
    Browser-library. The tests are divided into 2 separate suites, one for testing the login page and one
    for testing the basic path of using the store, including some basic input testing.

    The reason for using a playwright-based library instead of the more established libraries, such as selenium,
    was that the browser-library, while less established, is more modern in terms of architecture and provides
    very helpful and clearly defined keywords to base my learning on. While this proved a challenge at times,
    the problems I faced in this project provided me with some good tool to work on similar problems in the future.

How to install and run the Project
    To install the necessary libraries to run the project, run the following command in the terminal, once you have
    moved to the root of the project folder.
    pip install -r requirements
    
    After which you need to run the following command:
    rfbrowser init

    After running these 2 commands, run the following command in the root of the project
    robot tests
