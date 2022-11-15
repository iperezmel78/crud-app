import { Component, OnInit } from '@angular/core';
import { PostService } from '../post.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Post } from '../post';
import { FormGroup, FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss']
})
export class EditComponent implements OnInit {

  id!: number;
  post!: Post;
  form!: FormGroup;

  constructor(
    public postService: PostService,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  /**
   * Write code on Method
   *
   * @return response()
   */
  ngOnInit(): void {
    this.id = this.route.snapshot.params['postId'];
    this.form = new FormGroup({
      id: new FormControl(this.id, Validators.required),
      title: new FormControl('', Validators.required),
      body: new FormControl('', Validators.required)
    });
    this.postService.find(this.id).subscribe((data: Post) => {
      this.post = data;
      this.form.patchValue(this.post);
    });
  }

  /**
   * Write code on Method
   *
   * @return response()
   */
  get f() {
    return this.form.controls;
  }

  /**
   * Write code on Method
   *
   * @return response()
   */
  submit() {
    this.postService.update(this.form.value).subscribe((res: any) => {
      this.router.navigateByUrl('post/index');
    });
  }

}
