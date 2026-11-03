require "test_helper"

class PostsPageTest < ActionDispatch::IntegrationTest
  test "The new post page shows a form with fields for the author, the body and the image." do
    get("/posts/new")

    assert_response(:success)
    assert_select("form[action='/posts'][method='post']") do
      assert_select("input[name='author']")
      assert_select("input[name='body']")
      assert_select("input[name='image']")
      assert_select("button")
    end
  end

  test "Submitting the form creates a post with the author, body and image that were entered." do
    post("/posts", :params => { "author" => "Kajal", "body" => "Al pastor Tuesday", "image" => "https://images.unsplash.com/taco.jpg" })

    new_post = Post.last
    assert_equal("Kajal", new_post["author"])
    assert_equal("Al pastor Tuesday", new_post["body"])
    assert_equal("https://images.unsplash.com/taco.jpg", new_post["image"])
  end

  test "After submitting, the user lands on the posts page and sees the new post there." do
    post("/posts", :params => { "author" => "Kajal", "body" => "Al pastor Tuesday", "image" => "https://images.unsplash.com/taco.jpg" })

    assert_redirected_to("/posts")
    follow_redirect!
    assert_response(:success)
    assert_select("h3", { :text => "Kajal" })
    assert_select("p", { :text => "Al pastor Tuesday" })
    assert_select("img[src='https://images.unsplash.com/taco.jpg']")
  end
end
