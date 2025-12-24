package com.kh.moviediary.like.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentLike {
    private int commentId;
    private String userId;
    private String likeType;
}
