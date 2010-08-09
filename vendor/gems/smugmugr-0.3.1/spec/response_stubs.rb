def user_albums
  <<-END
  {
    "method"=>"smugmug.albums.get", 
    "Albums"=>[
      {
        "ImageCount"=>2, "Public"=>false, "Title"=>"temp", "id"=>8367181, "PasswordHint"=>"", "Password"=>"", "LastUpdated"=>"2009-05-28 18:39:25", 
        "Description"=>"", "Key"=>"jcrvi", "Category"=>{"Name"=>"Nora", "id"=>470426}
      }, 
      {
        "ImageCount"=>3, "Public"=>false, "Title"=>"Nora's Fifth Quarter", "id"=>8229534, "PasswordHint"=>"the state we live in", 
        "Password"=>"ma", "LastUpdated"=>"2009-05-28 15:21:55", "Description"=>"", "Key"=>"Yb6MW", "Category"=>{"Name"=>"Nora", "id"=>470426}
      }, 
      {
        "ImageCount"=>1, "Public"=>true, "Title"=>"My Smug Mug", "id"=>8316808,"PasswordHint"=>"", "Password"=>"", "LastUpdated"=>"2009-05-24 14:32:44", 
        "Description"=>"", "Key"=>"EFtqF", "Category"=>{"Name"=>"Other", "id"=>0}
      },
      {
        "ImageCount"=>29, "Public"=>true, "Title"=>"A Public Gallery", "id"=>82207, "PasswordHint"=>"", "Password"=>"", 
        "LastUpdated"=>"2009-05-16 15:23:11", "Description"=>"neat description", "Key"=>"FMUv", "Category"=>{"Name"=>"Nora","id"=>470426}
      }, 
      {
        "ImageCount"=>0, "Public"=>false, "Title"=>"Nora's First Quarter", "id"=>8229510, "PasswordHint"=>"", "Password"=>"", 
        "LastUpdated"=>"2009-05-16 14:42:30", "Description"=>"", "Key"=>"iqRdw", "Category"=>{"Name"=>"Nora", "id"=>470426}
      }
    ], 
    "stat"=>"ok"}
  END
end