# TGM
Its a very simple JSON serializer. 
## Installation
Step 1. Pull the github repo

Step 2. Run below command to install bundle
```bash
$ bundle install
```
Step 3. Run below command to run specs
```bash
$ Rspec spec
```

# Documentation

## Simple Serializer
The other serializers inherit this base serializer class to enable the methods to retrieve serializer data.

This class contains methods for attributes, associations, and defining JSON values. The as json method uses these to produce a JSON hash.

Additionally, we have a base configuration class that contains getter and setter methods for creating various hashes in accordance with the singleton serializer attributes and associations, as well as for retrieving the associations JSON hash.

### Set method for association hash ( Assocation )

```ruby
def set_hash(association_hash) 
  .....
end
```
### Get Method for association JSON Hash
```ruby
def get_hash(association_hash, object)
  .....
end
```

