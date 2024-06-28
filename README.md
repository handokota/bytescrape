# Twitter Forensik

## Import db command
psql -h twitter-forensik-twitter-forensik.d.aivencloud.com -p 15675 -d defaultdb -U avnadmin -f twitterinstagram.sql

## Export db command
pg_dump -U avnadmin -h twitter-forensik-twitter-forensik.d.aivencloud.com -p 15675 -d defaultdb > twitterinstagram.sql


## How to install
1. Clone this repository and save to anywhere what you want to
2. Copy .env.example to .env 
3. Configure the database setting, or if you want, you can use DB DEV SAMPLE configuration with uncomment the configuration (remove the # sign to uncomment)
4. Type ```composer install``` to install the necessary laravel's library
5. Type ```php artisan key:generate``` to generate a secure key for the laravel encryption engine
6. After that, run ```php artisan serve``` and open the ```localhost:8000``` link to open your project
7. Done