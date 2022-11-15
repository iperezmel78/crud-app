import { Component, OnInit } from '@angular/core';
import { PostService } from '../post.service';
import { Post } from '../post';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.scss']
})
export class IndexComponent implements OnInit {

  posts: Post[] = [];

  constructor(public postService: PostService) { }

  /**
   * Write code on Method
   *
   * @return response()
   */
  ngOnInit(): void {
    this.postService.getAll().subscribe((data: Post[]) => {
      this.posts = data;
    });
  }

  /**
   * Write code on Method
   *
   * @return response()
   */
  deletePost(id: number) {
    this.postService.delete(id).subscribe(res => {
      this.posts = this.posts.filter(item => item.id !== id);
    });
  }

}
